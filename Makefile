all:
	$(MAKE) -C languageSpec all
	$(MAKE) -C standardPrelude all
	$(MAKE) -C website all
	$(MAKE) -C embedded-web-editor deploy
