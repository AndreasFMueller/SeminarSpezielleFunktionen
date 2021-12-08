#
# Makefile
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	airy.pdf 

airy:	airy.cpp
	g++ -o airy -Wall -g -O2 `pkg-config --cflags gsl` airy.cpp `pkg-config --libs gsl`

airypaths.tex:	airy
	./airy --debug

airy.pdf:	airy.tex airypaths.tex
	pdflatex airy.tex
