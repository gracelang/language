all: pdf html

PANDOCOPTS = --table-of-contents --number-sections --from=markdown+tex_math_dollars
LATEXOPTS = --listings --template=grace.latex

munged.md:
	perl grammarator.perl spec.md  > munged.md 

pdf:
	@$(MAKE) spec.pdf standard.pdf munged.pdf

html:
	@$(MAKE) spec.html standard.html munged.html

%.pdf: %.md Makefile grace.sty grace.latex
	pandoc --standalone $(PANDOCOPTS) -o $@ --to=latex $(LATEXOPTS) $<

%.html: %.md Makefile
	pandoc --standalone $(PANDOCOPTS) -o $@ --to=html --self-contained $<

%.tex: %.md Makefile grace.sty grace.latex
	pandoc --standalone $(PANDOCOPTS) -o $@ --to=latex $(LATEXOPTS) $<
