all: pdf html

PANDOCOPTS= --table-of-contents --number-sections

pdf:
	@$(MAKE) spec.pdf standard.pdf 

html:
	@$(MAKE) spec.html standard.html

spec.pdf: spec.md
	pandoc --standalone $(PANDOCOPTS) -o spec.pdf --to=latex spec.md

spec.html: spec.md
	pandoc --standalone $(PANDOCOPTS) -o spec.html --to=html spec.md

spec.tex: spec.md
	pandoc --standalone $(PANDOCOPTS) -o spec.tex --to=latex spec.md



standard.pdf: standard.md
	pandoc --standalone $(PANDOCOPTS) -o standard.pdf --to=latex standard.md

standard.html: standard.md
	pandoc --standalone $(PANDOCOPTS) -o standard.html --to=html standard.md

standard.tex: standard.md
	pandoc --standalone $(PANDOCOPTS) -o standard.tex --to=latex standard.md
