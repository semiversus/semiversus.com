#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals
from datetime import datetime
import subprocess
import urllib

#SITENAME = 'Semiversus Blog' # for ATOM Feed
SITEURL = '.'
RELATIVE_URLS = True

#CACHE_CONTENT=True
#LOAD_CONTENT_CACHE=True
#GZIP_CACHE=False
#CONTENT_CACHING_LAYER='reader'
#WITH_FUTURE_DATES=False

TIMEZONE='Europe/Vienna'
#YEAR = datetime.now().year
#DEFAULT_DATE_FORMAT='%-d.%-m.%Y'
#DEFAULT_DATE='fs'

#FEED_ALL_ATOM='semiversus.atom.xml'
#CATEGORY_FEED_ATOM = None
#AUTHOR_FEED_ATOM = None
#AUTHOR_FEED_RSS = None
#TRANSLATION_FEED_ATOM = None

DIRECT_TEMPLATES=['index', 'error']
#ARCHIVES_SAVE_AS=''
#TAGS_SAVE_AS=''
#TAG_SAVE_AS='tag_{slug}.html'
#TAG_URL='tag_{slug}.html'
#CATEGORY_SAVE_AS=''
#CATEGORIES_SAVE_AS=''
#CATEGORY_URL=''
#AUTHORS_SAVE_AS=''
#AUTHOR_SAVE_AS=''
#AUTHOR_URL=''

# DEFAULT_PAGINATION=25

#OUTPUT_SOURCES=True
#OUTPUT_SOURCES_EXTENSION='.md'

THEME='theme'
THEME_STATIC_PATHS=['static']

#STATIC_PATHS = []
#EXTRA_PATH_METADATA = {}

PATH_METADATA= '(?P<dirname>.*)/(?P<basename>.*)\..*'
FILENAME_METADATA='(?P<basename>.*)'

PAGE_PATHS=['dic', 'projekte', 'pages']
PAGE_URL='{dirname}/{basename}.html'
PAGE_SAVE_AS='{dirname}/{basename}.html'

ARTICLE_PATHS=['blog']
ARTICLE_URL='blog/{basename}.html'
ARTICLE_SAVE_AS='blog/{basename}.html'

#DEFAULT_LANG='de'
#AUTHOR='Günther Jena'

PLUGIN_PATHS=['plugins']
#MD_EXTENSIONS=['codehilite(linenums=False)', 'plugins.mdx_tt', 'plugins.mdx_admonition', 'plugins.mdx_attr_list', 'plugins.mdx_downheader(levels=1)', 'tables']
PLUGINS=['convert_static', 'pageish', 'toc', 'summary']

CONVERT_PATHS = ['dic', 'blog', 'projekte', 'pages']
CONVERT_FILENAMES=[('.svg.tex', '.svg'), ('.compress', '.zip')]
CONVERT_RULES=[
  ('.compress', 'cd {dst_path} && cp {src} {basename} -r && zip -r {basename}.zip {basename}/* && rm {basename} -r'),
  ('.svg.tex', 'cd {dst_path} && cp {src} {basename}.tex && (ls {src_path}/*.sty && cp {src_path}/*.sty {dst_path} || true) && pdflatex -interaction=nonstopmode -halt-on-error {basename}.tex && pdf2svg {basename}.pdf {basename}.svg; rm {basename}.log {basename}.aux {basename}.dvi {basename}.nav {basename}.out {basename}.snm {basename}.pdf {basename}.toc {basename}.vrb {basename}.tex -rf'),
  ('.sty', ''),
  ('', 'cp {src} {dst_path}{basename}'),
]

EXTENDED_SITEMAP_PLUGIN = {
    'priorities': {
        'index': 1.0,
        'articles': 0.8,
        'pages': 0.5,
        'others': 0.4
    },
    'changefrequencies': {
        'index': 'daily',
        'articles': 'weekly',
        'pages': 'monthly',
        'others': 'monthly',
    }
}
