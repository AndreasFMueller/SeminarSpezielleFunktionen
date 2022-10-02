#
# tancf.m -- pade approximant for tan(z)
#
# (c) 2022 Prof Dr Andreas Müller
#
global N;
N = 10;

function retval = tanp(z)
	global N;
	q = -z^2;
	Q = [ 0, z; 1, 1 ];
	for k = (1:N)
		Q = Q * [ 0, q ; 1, 2*k+1 ];
	endfor
	retval = Q(1,2) / Q(2,2);
end

format long;

tanp(1)
tan(1)

tanp(pi/2 - 0.00001)
tan(pi/2 - 0.00001)
