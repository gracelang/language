all: pdf html kramdown

PANDOCOPTS = --table-of-contents --number-sections --from=markdown+tex_math_dollars+superscript
LATEXOPTS = --listings --template=grace.latex

pdf: standard.pdf

html: standard.html

kramdown: standard.kramdown

%.html: %.md Makefile
	pandoc --standalone $(PANDOCOPTS) -o $@ --to=html --self-contained $<

%.pdf: %.md Makefile grace.sty grace.latex
	pandoc --standalone $(PANDOCOPTS) -o $@ --to=latex $(LATEXOPTS) $<

%.tex: %.md Makefile grace.sty grace.latex
	pandoc --standalone $(PANDOCOPTS) -o $@ --to=latex $(LATEXOPTS) $<

%.kramdown: %.md dollarEscapes
	sed -f dollarEscapes > $@ $<
