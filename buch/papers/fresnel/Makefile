#
# Makefile -- make file for the paper fresnel
#
# (c) 2022 Prof Dr Andreas Mueller
#
all:	fresnelgraph.pdf eulerspirale.pdf pfad.pdf

images:
	@echo "no images to be created in fresnel"

eulerpath.tex:	eulerspirale.m
	octave eulerspirale.m

fresnelgraph.pdf:	fresnelgraph.tex eulerpath.tex
	pdflatex fresnelgraph.tex

eulerspirale.pdf:	eulerspirale.tex eulerpath.tex
	pdflatex eulerspirale.tex

pfad.pdf:	pfad.tex
	pdflatex pfad.tex

