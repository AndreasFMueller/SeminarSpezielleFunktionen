#
# Makefile -- build and execute some interesting numerical computation
#             programs
# 
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
all:	lambertw-test

xxl:	xxl.c
	gcc -o xxl -W -O2 -lgsl xxl.c

lambertw:	lambertw.c
	gcc -o lambertw -W -O2 lambertw.c

lambertw-test:	lambertw
	./lambertw -l l.txt -- -0.35 -0.367 -0.3678 -0.36787 -0.367879 -0.2 1 2 3 10 100 1000 -0.1 -0.01 -0.001 -0.0001

