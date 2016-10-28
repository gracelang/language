#This makefile provides standard build and serve functionality
#through jekyll for this project
LINEBREAK = "*****************************************************************"
WEB_SERVER = grace@linux.cs.pdx.edu
BASE_URL = /~grace/doc
WEB_SERVER_URL = http://cs.pdx.edu
WEB_DIRECTORY = public_html/doc/

.PHONEY = build deploy serve
all: deploy

_config.yml: config.yml.in Makefile
	sed -e "s|<<BASE_URL>>|$(BASE_URL)|; s|<<WEB_SERVER_URL>>|$(WEB_SERVER_URL)|" $< > $@

serve: build
	@echo "Running command:"
	bundle exec jekyll serve --skip-initial-build

../languageSpec/spec.pdf:
	$(MAKE) -C ../languageSpec $(@F)

../languageSpec/spec.kramdown:
	$(MAKE) -C ../languageSpec $(@F)

../standardPrelude/standard.pdf:
	$(MAKE) -C ../standardPrelude $(@F)

../standardPrelude/standard.kramdown:
	$(MAKE) -C ../standardPrelude $(@F)

build: _config.yml ../standardPrelude/standard.pdf ../standardPrelude/standard.kramdown ../languageSpec/spec.pdf ../languageSpec/spec.kramdown
	$(info Generating source files...)
	./loadResources
	./checkJekyll
	@echo Building the website... Running command:
	bundle exec jekyll build relative
	@echo ${LAST_EXIT}
	@echo The website has been built and is stored in the \"_site\" folder. It can now be
	@echo added to a server. If you wish to run it on localhost:4000, use "make serve"
	@echo ${LAST_EXIT}

deploy: build
	@echo Deploying website to grace@linux.cs.pdx.edu
	@[ -n "$(WEB_SERVER)" ] || { echo "Please set the WEB_SERVER variable to something like user@hostname" && false; }
	rsync -a -l -z --delete _site/ $(WEB_SERVER):$(WEB_DIRECTORY)

