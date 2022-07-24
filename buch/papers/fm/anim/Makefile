#
# Makefile
#
# (c) 2022 Prof Dr Andreas Müller
#
all:	animation.pdf

parts.tex:	fm.m
	octave fm.m

animation.pdf:	animation.tex parts.tex
	pdflatex animation.tex
