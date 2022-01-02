#
# Makefile
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	gammaplot.pdf fibonacci.pdf

gammaplot.pdf:	gammaplot.tex gammapaths.tex
	pdflatex gammaplot.tex

gammapaths.tex:	gammaplot.m
	octave gammaplot.m

fibonaccigrid.tex:	fibonacci.m
	octave fibonacci.m

fibonacci.pdf:	fibonacci.tex fibonaccigrid.tex
	pdflatex fibonacci.tex
