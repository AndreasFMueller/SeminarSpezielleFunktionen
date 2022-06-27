#
# Makefile
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	sn

sn:	sn.cpp
	g++ -O -Wall -g -std=c++11 sn.cpp -o sn `pkg-config --cflags gsl` `pkg-config --libs gsl`


agm:	agm.cpp
	g++ -O -Wall -g -std=c++11 agm.cpp -o agm `pkg-config --cflags gsl` `pkg-config --libs gsl`
	./agm

