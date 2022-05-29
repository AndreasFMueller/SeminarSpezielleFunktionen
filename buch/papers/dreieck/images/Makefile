#
# Makefile
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	order.pdf beta.pdf

order.pdf:	order.tex orderpath.tex
	pdflatex order.tex

orderpath.tex:	order.m
	octave order.m

beta.pdf:	beta.tex betapaths.tex
	pdflatex beta.tex

betapaths.tex:	betadist.m
	octave betadist.m
