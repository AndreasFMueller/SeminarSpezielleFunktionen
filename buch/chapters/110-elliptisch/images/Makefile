#
# Makefile -- make images
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	lemniskate.pdf ellipsenumfang.pdf unvollstaendig.pdf rechteck.pdf

lemniskate.pdf:	lemniskate.tex
	pdflatex lemniskate.tex

ellipsenumfang.pdf:	ellipsenumfang.tex ekplot.tex
	pdflatex ellipsenumfang.tex

ekplot.tex:	ellipsenumfang.m
	octave ellipsenumfang.m

rechteck:	rechteck.cpp
	g++ `pkg-config --cflags gsl` `pkg-config --libs gsl` -O -Wall -g -std=c++11 rechteck.cpp -o rechteck

rechteckpfade.tex:	rechteck
	./rechteck --outfile rechteckpfade.tex

rechteck.pdf:	rechteck.tex rechteckpfade.tex
	pdflatex rechteck.tex

unvollstaendig.pdf:	unvollstaendig.tex unvollpath.tex
	pdflatex unvollstaendig.tex

unvollpath.tex:	unvollstaendig.m
	octave unvollstaendig.m



