all: pdf html

PANDOCOPTS = --table-of-contents --number-sections --from=markdown+tex_math_dollars+superscript
LATEXOPTS = --listings --template=grace.latex

spec_with_grammar.md: spec.md grammar.grace grammarator.perl
	perl grammarator.perl $<  > $@

pdf: standard.pdf spec_with_grammar.pdf

html: standard.html spec_with_grammar.html

%.pdf: %.md Makefile grace.sty grace.latex
	pandoc --standalone $(PANDOCOPTS) -o $@ --to=latex $(LATEXOPTS) $<

%.html: %.md Makefile
	pandoc --standalone $(PANDOCOPTS) -o $@ --to=html --self-contained $<

%.tex: %.md Makefile grace.sty grace.latex
	pandoc --standalone $(PANDOCOPTS) -o $@ --to=latex $(LATEXOPTS) $<
