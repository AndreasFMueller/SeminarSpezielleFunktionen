#
# Makefile -- make images
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	lemniskate.pdf ellipsenumfang.pdf unvollstaendig.pdf

lemniskate.pdf:	lemniskate.tex
	pdflatex lemniskate.tex

ellipsenumfang.pdf:	ellipsenumfang.tex ekplot.tex
	pdflatex ellipsenumfang.tex

ekplot.tex:	ellipsenumfang.m
	octave ellipsenumfang.m

rechteck:	rechteck.cpp
	g++ -O -Wall -g rechteck.cpp -o rechteck

test:	rechteck
	./rechteck

unvollstaendig.pdf:	unvollstaendig.tex unvollpath.tex
	pdflatex unvollstaendig.tex

unvollpath.tex:	unvollstaendig.m
	octave unvollstaendig.m
