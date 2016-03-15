#!/usr/bin/env python

import markdown
import jinja2

from pelican import signals
from pelican.readers import MarkdownReader
from pelican.utils import pelican_open, get_date


class SlideReader(MarkdownReader):
  file_extensions = ['mds']

  def read(self, filename):
    with pelican_open(filename) as text:
      md_slides = text.split('\n---\n')

      slides = []
      # Process each slide separately.
      for md_slide in md_slides:
        slide = {}
        sections = md_slide.split('\n\n')
        # Extract metadata at the beginning of the slide (look for key: value)
        # pairs.
        metadata_section = sections[0]
        metadata = self.parse_metadata(metadata_section)
        slide.update(metadata)
        remainder_index = metadata and 1 or 0
        # Get the content from the rest of the slide.
        content_section = '\n\n'.join(sections[remainder_index:])
        html = markdown.markdown(content_section, extensions=self.extensions)
        slide['content'] = self.postprocess_html(html, metadata)
        slides.append(slide)
      metadata={'slides':slides, 'title':slides[0]['title'], 'date':get_date(slides[0]['date']), 'template':'slide'}
      return "", metadata

  def parse_metadata(self, section):
    """Given the first part of a slide, returns metadata associated with it."""
    metadata = {}
    metadata_lines = section.split('\n')
    for line in metadata_lines:
      colon_index = line.find(':')
      if colon_index != -1:
        key = line[:colon_index].strip()
        val = line[colon_index + 1:].strip()
        metadata[key] = val

    return metadata

  def postprocess_html(self, html, metadata):
    """Returns processed HTML to fit into the slide template format."""
    if metadata.get('build_lists') and metadata['build_lists'] == 'true':
      html = html.replace('<ul>', '<ul class="build">')
      html = html.replace('<ol>', '<ol class="build">')

    return html

def add_reader(readers):
  readers.reader_classes['mds'] = SlideReader

def register():
  signals.readers_init.connect(add_reader)
