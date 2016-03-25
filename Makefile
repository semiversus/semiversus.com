build: 
	@echo "Building website"
	@pelican content

debug:
	@echo "Building website (with -D flag)"
	@pelican content -D

view: build
	@python -m webbrowser -t file://`pwd`/output/index.html

upload: build
	cd output; git add --all; git commit -m "automated push"; git push https://semiversus@github.com/semiversus/semiversus.github.io/output
	ssh guenther@semiversus.com './update_semiversus.sh'

clean:
	rm cache -rf

.PHONY: build view upload clean
