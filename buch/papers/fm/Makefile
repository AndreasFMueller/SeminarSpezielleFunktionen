#
# Makefile -- make file for the paper fm
#
# (c) 2020 Prof Dr Andreas Mueller
#

SOURCES := \
	01_AM-FM.tex \
	02_frequenzyspectrum.tex \
	03_bessel.tex \
	04_fazit.tex \
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
			--output-directory=papers/fm/standalone \
			papers/fm/standalone.tex;
	cd standalone; \
		bibtex standalone; \
		makeindex standalone;