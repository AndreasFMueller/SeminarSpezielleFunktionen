#
# curvature.m
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#

global N;
N = 10;

global sigma2;
sigma2 = 1;

global s;
s = 1;

xmin = -3;
xmax = 3;
xsteps = 1000;
hx = (xmax - xmin) / xsteps;

ymin = -2;
ymax = 2;
ysteps = 1000;
hy = (ymax - ymin) / ysteps;

function retval = f0(r)
	global sigma2;
	retval = exp(-r^2/sigma2)/sigma2 - exp(-r^2/(2*sigma2))/(sqrt(2)*sigma2);
end

global N0;
N0 = f0(0);

function retval = f1(x,y)
	global N0;
	retval = f0(hypot(x, y)) / N0;
endfunction

function retval = f(x, y)
	global s;
	retval = f1(x+s, y) - f1(x-s, y);
endfunction

function retval = curvature0(r)
	global sigma2;
	retval = (
		(2*sigma2-r^2)*exp(-r^2/(2*sigma2))
		+
		4*(r^2-sigma2)*exp(-r^2/sigma2)
	) / (sigma2^2);
endfunction

function retval = curvature1(x, y)
	retval = curvature0(hypot(x, y));
endfunction

function retval = curvature(x, y)
	global s;
	retval = curvature1(x+s, y) + curvature1(x-s, y);
endfunction

function retval = farbe(x, y)
	c = curvature(x, y);
	retval = c * ones(1,3);
endfunction

fn = fopen("curvature.inc", "w");

for ix = (0:xsteps)
	x = xmin + ix * hx;
	for iy = (0:ysteps)
		y = ymin + iy * hy;
		fprintf(fn, "sphere { <%.4f, %.4f, %.4f>, 0.01\n",
			x, f(x, y), y);
		color = farbe(x, y);
		fprintf(fn, "pigment { color rgb<%.4f,%.4f,%.4f> }\n",
			color(1,1), color(1,2), color(1,3));
		fprintf(fn, "finish { metallic specular 0.5 }\n");
		fprintf(fn, "}\n");
	end
end

fclose(fn);
