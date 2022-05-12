#
# Makefile to build images 
#
# (c) 2022
#

dreieck.pdf:	dreieck.tex dreieckdata.tex macros.tex
	pdflatex dreieck.tex

dreieckdata.tex:	pk.m
	octave pk.m
