#
# Makefile
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	gammaplot.pdf fibonacci.pdf order.pdf beta.pdf

gammaplot.pdf:	gammaplot.tex gammapaths.tex
	pdflatex gammaplot.tex

gammapaths.tex:	gammaplot.m
	octave gammaplot.m

fibonaccigrid.tex:	fibonacci.m
	octave fibonacci.m

fibonacci.pdf:	fibonacci.tex fibonaccigrid.tex
	pdflatex fibonacci.tex

order.pdf:      order.tex orderpath.tex
	pdflatex order.tex

orderpath.tex:  order.m
	octave order.m

beta.pdf:       beta.tex betapaths.tex
	pdflatex beta.tex

betapaths.tex:  betadist.m
	octave betadist.m


