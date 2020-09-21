vlocal:
	@echo "Building local website"
	@PYTHONPATH='.' pelican content -s pelicanconf_local.py --cache-path=cache/local/ -o output_local

public:
	@echo "Building public website"
	@pelican content

dic:
	@echo "Building dic script"
	@PYTHONPATH='.' pelican content -s pelicanconf_dic.py --cache-path=cache/dic/ -o dic_script

debug:
	@echo "Building website (with -D flag)"
	@pelican content -D

view: local
	@python2 -m webbrowser -t file://`pwd`/output_local/index.html

upload:
	rsync -avz output/ root@semiversus.com:/srv/data/nginx/semiversus_static/

clean:
	rm cache dic_script output_local __pycache__ *.pyc -rf

optimize:
	find content -name \*.png|xargs optipng -o2
	find content -name \*.jpg|xargs jpegoptim -s -m90

build-docker:
	docker build -t guenther.jena/pelican .

run-docker:
	docker run -t -v `pwd`:/site guenther.jena/pelican


.PHONY: public local view upload clean
