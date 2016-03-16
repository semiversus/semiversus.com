build: 
	@echo "Building website"
	@pelican content

view: build
	@python -m webbrowser -t file://`pwd`/output/index.html

upload: build
	cd output; git add --all; git commit -m "automated push"; git push

clean:
	rm cache -rf

.PHONY: build view upload clean
