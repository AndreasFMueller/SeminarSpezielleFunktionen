FIGURES := spherical-coordinates.pdf curvature-1d.pdf

all: $(FIGURES)

%.pdf: %.tex
	pdflatex $<

curvature-1d.pdf: curvature-1d.tex curvature-1d.dat
	pdflatex curvature-1d.tex

curvature-1d.dat: curvature-1d.py
	python3 $<
