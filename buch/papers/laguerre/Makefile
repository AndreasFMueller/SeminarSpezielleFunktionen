#
# Makefile -- make file for the paper laguerre
#
# (c) 2020 Prof Dr Andreas Mueller
#
IMGFOLDER := images
PRESFOLDER := presentation

FIGURES := \
	images/targets.pdf \
	images/rel_error_complex.pdf \
	images/estimates.pdf \
	images/integrand.pdf \
	images/integrand_exp.pdf \
	images/laguerre_poly.pdf \
	images/rel_error_mirror.pdf \
	images/rel_error_range.pdf \
	images/rel_error_shifted.pdf \
	images/rel_error_simple.pdf \
	images/gammaplot.pdf

.PHONY: all
all: images presentation

.PHONY: images
images: $(FIGURES)

.PHONY: presentation
presentation: $(PRESFOLDER)/presentation.pdf

images/%.pdf images/%.pgf: scripts/%.py
	python3 $<

images/gammaplot.pdf: images/gammaplot.tex images/gammapaths.tex
	cd $(IMGFOLDER) && latexmk -quiet -pdf gammaplot.tex

$(PRESFOLDER)/%.pdf: $(PRESFOLDER)/%.tex $(FIGURES)
	cd $(PRESFOLDER) && latexmk -quiet -pdf $(<F)

.PHONY: clean
clean:
	rm $(FIGURES)
	cd $(IMGFOLDER) && 	latexmk -C
	cd $(PRESFOLDER) && latexmk -C