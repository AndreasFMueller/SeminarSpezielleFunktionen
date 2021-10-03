#
# Makefile -- build the images
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#

simulation:	simulation.cpp
	g++ -Wall -O2 -g -o simulation `pkg-config --cflags Magick++` \
		simulation.cpp `pkg-config --libs Magick++`
test:	simulation
	./simulation 

video:	simulation
	./simulation --iterations=1000 test/
