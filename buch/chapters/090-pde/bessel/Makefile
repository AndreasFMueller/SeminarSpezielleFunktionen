#
# Makefile
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	besselzeros.tex besselnodes.tex pauke.pdf

besselzeros.tex:	besselzeros.m
	octave besselzeros.m

besselnodes.tex:	besselnodes.m
	octave besselnodes.m

pauke.pdf:	pauke.tex besselnodes.tex
	pdflatex pauke.tex
