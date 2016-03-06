all: pdf html

PANDOCOPTS= --table-of-contents --number-sections

pdf:
	@$(MAKE) spec.pdf

html:
	@$(MAKE) spec.html

spec.pdf: spec.md
	pandoc --standalone $(PANDOCOPTS) -o spec.pdf --to=latex spec.md


spec.html: spec.md
	pandoc --standalone $(PANDOCOPTS) -o spec.html --to=html spec.md


spec.tex: spec.md
	pandoc --standalone $(PANDOCOPTS) -o spec.tex --to=latex spec.md
