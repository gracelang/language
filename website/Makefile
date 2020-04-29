#This makefile provides standard build and serve functionality
#through jekyll for this project
LINEBREAK = "*****************************************************************"
WEB_SERVER = grace@linux.cs.pdx.edu
BASE_URL = /~grace/doc
WEB_SERVER_URL = http://cs.pdx.edu
WEB_DIRECTORY = public_html/doc/

.PHONEY = build deploy serve pdfs kramdowns all

all: deploy

_config.yml: config.yml.in Makefile
	sed -e "s|<<BASE_URL>>|$(BASE_URL)|; s|<<WEB_SERVER_URL>>|$(WEB_SERVER_URL)|" $< > $@

serve: build
	@echo "Running command:"
	bundle exec jekyll serve --skip-initial-build 2>&1 | egrep -v 'deprecated|called method'

pdfs:
	$(MAKE) -C ../languageSpec spec_with_grammar.pdf
	$(MAKE) -C ../standardPrelude standard.pdf

kramdowns:
	$(MAKE) -C ../languageSpec spec.kramdown
	$(MAKE) -C ../standardPrelude standard.kramdown

build: _config.yml pdfs kramdowns loadResources
	$(info Generating source files...)
	./loadResources
	./checkJekyll
	@echo Building the website... Running command:
	bundle exec jekyll build relative 2>&1 | egrep -v 'deprecated|called method'
	@echo ${LAST_EXIT}
	@echo The website has been built and is stored in the \"_site\" folder. It can now be
	@echo uploaded to a server. If you wish to test it on localhost, use \"make serve\"
	@echo ${LAST_EXIT}

deploy: build
	@echo Deploying website to grace@linux.cs.pdx.edu
	@[ -n "$(WEB_SERVER)" ] || { echo "Please set the WEB_SERVER variable to something like user@hostname" && false; }
	rsync -a -l -z --delete _site/ $(WEB_SERVER):$(WEB_DIRECTORY)

