PDF_SPECS = spec_with_grammar.pdf spec.pdf
LATEX_SPECS = $(PDF_SPECS:%.pdf=%.tex)
HTML_SPECS = $(PDF_SPECS:%.pdf=%.html)

PANDOCOPTS = --table-of-contents --number-sections --from=markdown+tex_math_dollars+superscript+subscript
LATEXOPTS = --listings --template=grace.latex

all: $(PDF_SPECS) $(HTML_SPECS) spec.kramdown

spec_with_grammar.md: spec.md graceGrammar.txt grammarator.perl Makefile
	perl grammarator.perl $<  > $@

$(PDF_SPECS): %.pdf: %.tex Makefile lstfixes grace.sty grace.latex
	sed -f lstfixes $< > fixed-$<
	pdflatex fixed-$< && mv fixed-$@ $@

$(LATEX_SPECS): %.tex: %.md Makefile
	pandoc --standalone $(PANDOCOPTS) -o $@ --to=latex $(LATEXOPTS) $<

$(HTML_SPECS): %.html: %.md Makefile
	pandoc --standalone $(PANDOCOPTS) -o $@ --to=html --self-contained $<

%.tex: %.md Makefile grace.sty grace.latex
	pandoc --standalone $(PANDOCOPTS) -o $@ --to=latex $(LATEXOPTS) $<

spec.kramdown: spec_with_grammar.md dollarEscapes
	sed -f dollarEscapes > $@ $<
