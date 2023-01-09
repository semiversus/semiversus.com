#!/bin/bash
docker run --rm  -p 1948:1948 -p 35729:35729 -v `pwd`:/slides webpronl/reveal-md:latest /slides --static
docker run --rm  -p 1948:1948 -p 35729:35729 -v `pwd`:/slides webpronl/reveal-md:latest /slides --watch