all: pdf html

pdf:
	@$(MAKE) spec.pdf

html:
	@$(MAKE) spec.html

spec.pdf: spec.md
	pandoc --standalone --output=spec.pdf --to=latex spec.md

spec.tex: spec.md
	pandoc --standalone --output=spec.tex --to=latex spec.md

spec.html: spec.md
	pandoc --standalone --output=spec.html --to=html spec.md
