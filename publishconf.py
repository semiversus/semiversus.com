from pelicanconf import *

SITEURL = 'https://www.semiversus.com'
RELATIVE_URLS = False

STATIC_PATHS = ['extra/robots.txt', 'extra/favicon.ico', 'extra/CNAME']
EXTRA_PATH_METADATA = {
  'extra/robots.txt':{'path':'robots.txt'},
  'extra/favicon.ico':{'path':'favicon.ico'},
  'extra/CNAME':{'path':'CNAME'},
  'extra/error.html':{'path':'error.html'},
}