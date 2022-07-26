#
# Makefile -- make file for the paper fm
#
# (c) 2020 Prof Dr Andreas Mueller
#

SOURCES := \
	einleitung.tex\
	teil1.tex \
	teil2.tex \
	teil3.tex \
	main.tex 

#TIKZFIGURES := \
	tikz/atoms-grid-still.tex \

#FIGURES := $(patsubst tikz/%.tex, figures/%.pdf, $(TIKZFIGURES))

#.PHONY: images
#images: $(FIGURES)

#figures/%.pdf: tikz/%.tex
#	mkdir -p figures
#	pdflatex --output-directory=figures $<

.PHONY: standalone
standalone: standalone.tex $(SOURCES)  #$(FIGURES)
	mkdir -p standalone
	cd ../..; \
		pdflatex \
			--halt-on-error \
			--shell-escape \
			--output-directory=papers/sturmliouville/standalone \
			papers/sturmliouville/standalone.tex;
	cd standalone; \
		bibtex standalone; \
		makeindex standalone;