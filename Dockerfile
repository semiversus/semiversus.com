cd ..
FROM ubuntu:16.04
MAINTAINER guenther.jena <guenther@jena.at>

RUN apt-get update
RUN apt-get install python-pip git zip -y
RUN pip install --upgrade pip
RUN pip install pelican==3.7.1 Markdown==2.6.8 pelican-minify==0.9 beautifulsoup4 webassets cssmin jsmin

WORKDIR /site

# Run Pelican
CMD pelican content
