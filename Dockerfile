FROM ubuntu:16.04
MAINTAINER guenther.jena <guenther@jena.at>

RUN apt-get update
RUN apt-get install python-pip git zip texlive-latex-recommended texlive-latex-extra -y
RUN pip install -U pip==19
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

WORKDIR /site

# Run Pelican
CMD pelican content
