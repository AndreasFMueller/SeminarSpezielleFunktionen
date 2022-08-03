#
# Makefile
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschlue
#
all:	KK.pdf

KN:	KN.cpp
	g++ -O -Wall -std=c++11 KN.cpp -o KN `pkg-config --cflags gsl` `pkg-config --libs gsl`

KKpath.tex:	KN
	./KN --outfile KKpath.tex

KK.pdf:	KK.tex KKpath.tex
	pdflatex KK.tex
