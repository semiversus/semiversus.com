from pelican import signals
import os

# Problem: utf8 characters are not properly handled 
def pageish(generator):
  pages_dict=dict([(page.get_relative_source_path(), page) for page in generator.pages])
  prev_dict={}

  for page in generator.pages:
    for field in ('next', 'parent'):
      if hasattr(page, field):
        path = getattr(page, field)
        if path.startswith('/'):
          path = path[1:]
        else:
          path=page.get_relative_source_path(os.path.join(page.relative_dir, path))
        if not path in pages_dict.keys():
          raise ValueError('Link to %s was not found (on page %s)'%(path.decode('utf8'), page))
        setattr(page, field, pages_dict[str(path)])
        if field=='next':
          setattr(page.next, 'prev', page)

  for page in generator.pages:
    for field in ('prev', 'next', 'parent'):
      pages=[]
      p=page
      while hasattr(p, field):
        p=getattr(p, field)
        pages.append(p)
      setattr(page, field+'_list', pages)

def register():
  signals.page_generator_finalized.connect(pageish)
