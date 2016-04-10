all: pdf html

PANDOCOPTS= --table-of-contents --number-sections --from=markdown+tex_math_dollars

TEXOPTS= --include-in-header=grace.sty

pdf:
	@$(MAKE) spec.pdf standard.pdf 

html:
	@$(MAKE) spec.html standard.html

%.pdf: %.md Makefile grace.sty
	pandoc --standalone $(PANDOCOPTS) -o $@ --to=latex --listings $(TEXOPTS) $<

%.html: %.md Makefile
	pandoc --standalone $(PANDOCOPTS) -o $@ --to=html --self-contained $<

%.tex: %.md Makefile grace.sty
	pandoc --standalone $(PANDOCOPTS) -o $@ --to=latex --listings $(TEXOPTS) $<
