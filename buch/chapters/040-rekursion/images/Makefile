#
# Makefile
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	gammaplot.pdf

gammaplot.pdf:	gammaplot.tex gammapaths.tex
	pdflatex gammaplot.tex

gammapaths.tex:	gammaplot.m
	octave gammaplot.m
