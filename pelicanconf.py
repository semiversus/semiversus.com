#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals
from datetime import datetime
import subprocess

SITEURL = '.'
RELATIVE_URLS = True

CACHE_CONTENT=True
LOAD_CONTENT_CACHE=True
GZIP_CACHE=False
CONTENT_CACHING_LAYER='reader'
WITH_FUTURE_DATES=False

TIMEZONE='Europe/Vienna'
YEAR = datetime.now().year
DEFAULT_DATE_FORMAT='%-d.%-m.%Y'

FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None
TRANSLATION_FEED_ATOM = None

DIRECT_TEMPLATES=['index', 'archives']
ARCHIVES_SAVE_AS=''
TAGS_SAVE_AS=''
CATEGORY_SAVE_AS=''
CATEGORIES_SAVE_AS=''
AUTHORS_SAVE_AS=''
AUTHOR_SAVE_AS=''

OUTPUT_SOURCES=True
OUTPUT_SOURCES_EXTENSION='.md'

THEME='theme'
THEME_STATIC_PATHS=['static']

STATIC_PATHS = ['extra/robots.txt', 'extra/favicon.ico', 'extra/foto.jpg', 'extra/CNAME']
EXTRA_PATH_METADATA = {
  'extra/robots.txt':{'path':'robots.txt'},
  'extra/favicon.ico':{'path':'favicon.ico'},
  'extra/foto.jpg':{'path':'foto.jpg'},
  'extra/CNAME':{'path':'CNAME'},
}

PATH_METADATA= '(?P<dirname>.*)/(?P<basename>.*)\..*'
FILENAME_METADATA='(?P<basename>.*)'

PAGE_PATHS=['dic', 'klassen', 'projekte', 'pages']
PAGE_URL='{dirname}/{basename}.html'
PAGE_SAVE_AS='{dirname}/{basename}.html'

ARTICLE_PATHS=['blog']
ARTICLE_URL='blog/{basename}.html'
ARTICLE_SAVE_AS='blog/{basename}.html'

DEFAULT_LANG='de'
#PAGE_LANG_URL='{dirname}/{basename}.html'
#PAGE_LANG_SAVE_AS='{dirname}/{basename}.html'
#ARTICLE_LANG_URL='blog/{basename}.html'
#ARTICLE_LANG_SAVE_AS='blog/{basename}-{lang}.html'
#STATIC_LANG_SAVE_AS=''
#STATIC_LANG_URL=''

#try:
GIT_DATE=datetime.strftime(datetime.strptime(subprocess.check_output('git show -s --format=%cd --date=short', shell=True).decode('utf-8').strip(),'%Y-%m-%d'), DEFAULT_DATE_FORMAT)
GIT_REVISION=subprocess.check_output('git show -s --format=%h', shell=True).decode('utf-8').strip()
#except:
#  GIT_DATE='unbekannt'
#  GIT_REVISION='neu'


PLUGIN_PATHS=['plugins']
MD_EXTENSIONS=['codehilite(linenums=False)', 'plugins.mdx_tt', 'plugins.mdx_admonition', 'extra']
PLUGINS=['convert_static', 'slides', 'pageish', 'toc', 'latex']

CONVERT_PATHS = ['dic', 'blog', 'projekte', 'klassen', 'pages']
CONVERT_FILENAMES=[('.svg', '.png'), ('.svg.tex', '.svg'), ('.compress', '.zip')]
CONVERT_RULES=[
  ('.compress', 'cd {dst_path} && cp {src} {basename} -r && zip -r {basename}.zip {basename}/* && rm {basename} -r'),
  ('.svg.tex', 'cd {dst_path} && cp {src} {basename}.tex && pdflatex -interaction=nonstopmode -halt-on-error {basename}.tex && pdf2svg {basename}.pdf {basename}.svg; rm {basename}.log {basename}.aux {basename}.dvi {basename}.nav {basename}.out {basename}.snm {basename}.pdf {basename}.toc {basename}.vrb {basename}.tex -rf'),
  ('.sty', ''),
  ('', 'cp {src} {dst_path}{basename}'),
]
