all: pdf html

PANDOCOPTS= --table-of-contents --number-sections --from=markdown+tex_math_dollars
LATEXOPTS= --listings --template=grace.latex

pdf:
	@$(MAKE) spec.pdf standard.pdf 

html:
	@$(MAKE) spec.html standard.html

%.pdf: %.md Makefile
	pandoc --standalone $(PANDOCOPTS) -o $@ --to=latex $(LATEXOPTS) $<

%.html: %.md Makefile
	pandoc --standalone $(PANDOCOPTS) -o $@ --to=html --self-contained $<

%.tex: %.md Makefile
	pandoc --standalone $(PANDOCOPTS) -o $@ --to=latex $(LATEXOPTS) $<
