from pelicanconf_local import *

SITEURL = '.'
RELATIVE_URLS = True

THEME='theme/dic'
STATIC_PATHS = []
PAGE_PATHS=['dic']
OUTPUT_SOURCES=False
ARTICLE_PATHS=[]
CONVERT_PATHS = ['dic']
FEED_ALL_ATOM=False

MD_EXTENSIONS=['codehilite(linenums=False)', 'plugins.mdx_tt', 'plugins.mdx_admonition', 'plugins.mdx_latex', 'extra']
PLUGINS=['convert_static', 'slides', 'pageish', 'toc', 'representative_image']
