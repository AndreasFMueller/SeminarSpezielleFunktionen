#
# Makefile -- build gamma limit test programm
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
l:	l.cpp
	g++ -O2 -g -Wall `pkg-config --cflags gsl` `pkg-config --libs gsl` \
		-o l l.cpp

test:	l
	./l
