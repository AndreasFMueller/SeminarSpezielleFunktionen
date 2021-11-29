#
# Makefile -- Gauss quadrature experiments
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	kreis gq.pdf

gq.o:	gq.cpp
	g++ `pkg-config --cflags gsl` -o gq.o -g -Wall -O2 -c gq.cpp 

gq:	gq.o
	g++ -g -Wall -O2 gq.o `pkg-config --libs gsl` -o gq

kreis:	kreis.cpp
	g++ `pkg-config --cflags gsl` -g -Wall -O2 kreis.cpp \
		`pkg-config --libs gsl` -o kreis

gqpaths.tex:	gq
	./gq > gqpaths.tex

gq.pdf:	gq.tex gqpaths.tex
	pdflatex gq.tex
