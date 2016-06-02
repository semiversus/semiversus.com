from pelican import signals
from pelican.generators import Static, Generator
from pelican.utils import mkdir_p, copy
from pelican.cache import FileStampDataCacher

from tempfile import mkdtemp
from shutil import rmtree
from subprocess import call
from zipfile import ZipFile
import os, shutil

def find_rule(src_path, rules):
  rules_dict=dict([(s,(d,c)) for s,d,c in rules])
  rules=[(s,d,f) for s, (d, f) in rules_dict.items() if src_path.endswith(s)]
  if len(rules):
    return rules[0]
  else:
    return None

class ConvertStaticGenerator(Generator):
    def __init__(self, *args, **kwargs):
        super(ConvertStaticGenerator, self).__init__(*args, **kwargs)
        self.rules=self.settings.get('CONVERT_RULES', [])
        self.cache=FileStampDataCacher(self.settings, self.__class__.__name__, True, True)

    def get_files(self, paths):
        files = []
        for path in paths:
            root = os.path.join(self.path, path) if path else self.path

            if os.path.isdir(root):
                for dirpath, dirs, temp_files in os.walk(root, followlinks=True):
                    reldir = os.path.relpath(dirpath, self.path)
                    for f in temp_files+dirs:
                        fp = os.path.join(reldir, f)
                        if self.settings.get('STATIC_EXCLUDE_SOURCES', True):
                          if self._is_potential_source_path(fp):
                              continue
                        match_ext=[src_ext for( src_ext, rule) in self.rules if str(fp).endswith(src_ext)]
                        if len(match_ext):
                          if f in dirs:
                            if len(match_ext)!=1 or match_ext[0]!='':
                              dirs.remove(f)
                              files.append(fp)
                          else:
                            files.append(fp)
        return files

    def generate_context(self):
        for f in self.get_files(self.settings.get('CONVERT_PATHS', [])):

          static_file = self.readers.read_file(
              base_path=self.path, path=f, content_class=Static,
              fmt='static', context=self.context)

          match_ext=[src_ext for( src_ext, rule) in self.rules if str(f).endswith(src_ext)]
          if len(match_ext)!=1 or match_ext[0]!='':
            source_path = os.path.join(self.path, static_file.source_path)
            temp_path=mkdtemp()
            dst_path=os.path.join(self.output_path, os.path.dirname(static_file.save_as))
            mkdir_p(dst_path)
            content=self.cache.get_cached_data(source_path)
            if content:
              with open(temp_path+"/tmp.zip", "wb") as zfile:
                zfile.write(content)
              with ZipFile(temp_path+"/tmp.zip", "r") as zfile:
                zfile.extractall(temp_path)
              os.remove(temp_path+"/tmp.zip")
            else:
              src_ext, rule=[(src_ext, rule) for( src_ext, rule) in self.rules if str(source_path).endswith(src_ext)][0]
              call(rule.format(src=source_path, src_path=os.path.dirname(source_path), basename=os.path.basename(source_path).replace(src_ext,''), dst_path=temp_path+'/'), shell=True)
              zf = ZipFile(temp_path+"/tmp.zip", "w")
              for dirname, subdirs, files in os.walk(temp_path):
                #zf.write(dirname)
                for filename in files:
                  if filename=="tmp.zip":
                    continue
                  zf.write(os.path.join(dirname, filename), filename)
              zf.close()
              with open(temp_path+"/tmp.zip", "rb") as zfile:
                content=zfile.read()
              os.remove(temp_path+"/tmp.zip")
              self.cache.cache_data(source_path, content)
            copy(temp_path, dst_path)
            rmtree(temp_path)
          else:
            source_path = os.path.join(self.path, static_file.source_path)
            save_as = os.path.join(self.output_path, static_file.save_as)
            mkdir_p(os.path.dirname(save_as))
            shutil.copy2(source_path, save_as)
          self.add_source_path(static_file)
        self.cache.save_cache()

def rewrite_filenames(static_generator):
  for pattern, content in static_generator.context['filenames'].items():
    matches=[(src_ext, dst_ext) for( src_ext, dst_ext) in static_generator.settings.get('CONVERT_FILENAMES', []) if content.source_path.endswith(src_ext)]
    if len(matches):
      src_ext, dst_ext=matches[0]
      static_generator.context['filenames'][pattern]=Static(None, source_path=pattern.replace(src_ext, dst_ext))
  
def get_generators(pelican):
  return ConvertStaticGenerator

def register():
    signals.get_generators.connect(get_generators)
    signals.static_generator_finalized.connect(rewrite_filenames) # better use all_generators_finalized (not available at 3.5.0)
