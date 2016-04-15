local:
	@PYTHONPATH='.' pelican content -s pelicanconf_local.py

public: 
	@echo "Building website"
	@pelican content

debug:
	@echo "Building website (with -D flag)"
	@pelican content -D

view: local
	@python -m webbrowser -t file://`pwd`/output/index.html

upload: public
	git push
	rm output/* -rf; make public; cd output; git add --all; git commit -m "automated push"; git push git@github.com:semiversus/semiversus.github.io.git
	ssh guenther@semiversus.com './update_semiversus.sh'

clean:
	rm cache -rf

.PHONY: public local view upload clean
