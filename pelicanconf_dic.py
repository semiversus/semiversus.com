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

MD_EXTENSIONS=['codehilite(linenums=False)', 'plugins.mdx_tt', 'plugins.mdx_admonition', 'plugins.mdx_latex', 'plugins.mdx_attr_list', 'tables']
PLUGINS=['convert_static', 'slides', 'pageish', 'toc', 'representative_image', 'assets']

CONVERT_FILENAMES=[('.svg.tex', '.png'), ('.svg', '.png'), ('.compress', '.zip')]
CONVERT_RULES=[
  ('.compress', 'cd {dst_path} && cp {src} {basename} -r && zip -r {basename}.zip {basename}/* && rm {basename} -r'),
  ('.svg', 'convert {src} {dst_path}{basename}.png'),
  ('.svg.tex', 'cd {dst_path} && cp {src} {basename}.tex && pdflatex -interaction=nonstopmode -halt-on-error {basename}.tex && pdf2svg {basename}.pdf {basename}.svg && convert {basename}.svg {basename}.png; rm {basename}.log {basename}.aux {basename}.dvi {basename}.nav {basename}.out {basename}.snm {basename}.pdf {basename}.toc {basename}.vrb {basename}.tex {basename}.svg -rf'),
  ('.sty', ''),
  ('', 'cp {src} {dst_path}{basename}'),
]
