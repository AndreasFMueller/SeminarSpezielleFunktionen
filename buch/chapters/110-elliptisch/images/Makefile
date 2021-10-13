#
# Makefile -- make images
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	lemniskate.pdf ellipsenumfang.pdf

lemniskate.pdf:	lemniskate.tex
	pdflatex lemniskate.tex

ellipsenumfang.pdf:	ellipsenumfang.tex ekpath.tex
	pdflatex ellipsenumfang.tex

ekpath.tex:	ellipsenumfang.m
	octave ellipsenumfang.m

