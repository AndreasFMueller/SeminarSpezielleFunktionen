#
# 1.m
#
#
n = 10;
format long;

function retval = snewtonstep(x, s)
	corr = (-4*x*x*x+3*x-s) / (-12*x*x + 3);
	retval = x - corr;
end

function retval = cnewtonstep(x, c)
	corr = (4*x*x*x-3*x-c) / (12*x*x - 3);
	retval = x - corr;
end

s0 = pi / 180;

s3 = sind(3)
c3 = cosd(3)

r = zeros(n+1,2)
r(1,1) = pi / 180;
r(1,2) = sqrt(1-r(1,1)^2);

for i = (1:n)
	r(i+1,1) = snewtonstep(r(i,1), s3);
	r(i+1,2) = cnewtonstep(r(i,2), c3);
endfor

r

