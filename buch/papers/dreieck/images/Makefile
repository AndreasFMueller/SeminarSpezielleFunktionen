#
# Makefile
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
order.pdf:	order.tex orderpath.tex
	pdflatex order.tex

orderpath.tex:	order.m
	octave order.m
