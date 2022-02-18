#
# Makefile -- make images
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	lemniskate.pdf ellipsenumfang.pdf unvollstaendig.pdf rechteck.pdf \
	ellipse.pdf pendel.pdf jacobiplots.pdf jacobidef.pdf jacobi12.pdf

lemniskate.pdf:	lemniskate.tex
	pdflatex lemniskate.tex

ellipsenumfang.pdf:	ellipsenumfang.tex ekplot.tex
	pdflatex ellipsenumfang.tex

ekplot.tex:	ellipsenumfang.m
	octave ellipsenumfang.m

rechteck:	rechteck.cpp
	g++ -O -Wall -g -std=c++11 rechteck.cpp -o rechteck `pkg-config --cflags gsl` `pkg-config --libs gsl`

rechteckpfade.tex:	rechteck
	./rechteck --outfile rechteckpfade.tex

rechteck.pdf:	rechteck.tex rechteckpfade.tex
	pdflatex rechteck.tex

unvollstaendig.pdf:	unvollstaendig.tex unvollpath.tex
	pdflatex unvollstaendig.tex

unvollpath.tex:	unvollstaendig.m
	octave unvollstaendig.m

ellipse.pdf:	ellipse.tex
	pdflatex ellipse.tex

pendel.pdf:	pendel.tex
	pdflatex pendel.tex

jacobi:	jacobi.cpp
	g++ -O -Wall -g -std=c++11 jacobi.cpp -o jacobi `pkg-config --cflags gsl` `pkg-config --libs gsl`

test:	blubb.tex

blubb.tex:	jacobi
	./jacobi --umax=14 --outfile=blubb.tex blubb 0.7

jacobipaths.tex:	jacobi Makefile
	./jacobi --umax=13 --steps=200 --outfile=jacobipaths.tex \
		zero 0.00 \
		one 0.2 \
		two 0.4 \
		three 0.6 \
		four 0.8 \
		five 0.9 \
		six 0.99 \
		seven 0.999 \
		eight 0.9999 \
		nine 0.99999 \
		ten 1.0

jacobiplots.pdf:	jacobiplots.tex jacobipaths.tex
	pdflatex jacobiplots.tex

jacobidef.pdf:	jacobidef.tex
	pdflatex jacobidef.tex

jacobi12.pdf:	jacobi12.tex
	pdflatex jacobi12.tex
