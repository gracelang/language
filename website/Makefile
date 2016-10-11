#This makefile provides standard build and serve functionality
#through jekyll for this project
LINEBREAK = "*****************************************************************"
WEB_SERVER = grace@linux.cs.pdx.edu
WEB_DIRECTORY = public_html/doc/

all: build deploy

serve:
	./checkJekyll
	@echo "Running command:"
	bundle exec jekyll serve

build:
	$(info Generating source files...)
	$(MAKE) -C ../languageSpec all
	$(MAKE) -C ../standardPrelude all
	./loadResources
	./checkJekyll
	@echo Building the website... Running command:
	bundle exec jekyll build relative
	@echo ${LAST_EXIT}
	@echo The website has been built and is stored in the \"_site\" folder. It can now be
	@echo added to a server. If you wish to run it on localhost:4000, use "make serve"
	@echo ${LAST_EXIT}

deploy:
	@[ -n "$(WEB_SERVER)" ] || { echo "Please set the WEB_SERVER variable to something like user@hostname" && false; }
	rsync -a -l -z --delete _site/ $(WEB_SERVER):$(WEB_DIRECTORY)

