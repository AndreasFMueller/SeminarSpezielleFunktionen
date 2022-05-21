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

global cmax;
cmax = 0.9;
global cmin;
cmin = -0.9;

global Cmax;
global Cmin;
Cmax = 0;
Cmin = 0;

xmin = -3;
xmax = 3;
xsteps = 200;
hx = (xmax - xmin) / xsteps;

ymin = -2;
ymax = 2;
ysteps = 200;
hy = (ymax - ymin) / ysteps;

function retval = f0(r)
	global sigma2;
	retval = exp(-r^2/sigma2)/sqrt(sigma2) - exp(-r^2/(2*sigma2))/(sqrt(2*sigma2));
end

global N0;
N0 = f0(0)
N0 = 0.5;

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
		-4*(sigma2-r^2)*exp(-r^2/sigma2)
		+
		(2*sigma2-r^2)*exp(-r^2/(2*sigma2))
	) / (sigma2^(5/2));
endfunction

function retval = curvature1(x, y)
	retval = curvature0(hypot(x, y));
endfunction

function retval = curvature(x, y)
	global s;
	retval = curvature1(x+s, y) - curvature1(x-s, y);
endfunction

function retval = farbe(x, y)
	global Cmax;
	global Cmin;
	global cmax;
	global cmin;
	c = curvature(x, y);
	if (c < Cmin) 
		Cmin = c
	endif
	if (c > Cmax) 
		Cmax = c
	endif
	u = (c - cmin) / (cmax - cmin);
	if (u > 1)
		u = 1;
	endif
	if (u < 0)
		u = 0;
	endif
	color = [ u, 0.5, 1-u ];
	color = color/max(color);
	color(1,4) = c/2;
	retval = color;
endfunction

function dreieck(fn, A, B, C)
	fprintf(fn, "\ttriangle {\n");
	fprintf(fn, "\t    <%.4f,%.4f,%.4f>,\n", A(1,1), A(1,3), A(1,2));
	fprintf(fn, "\t    <%.4f,%.4f,%.4f>,\n", B(1,1), B(1,3), B(1,2));
	fprintf(fn, "\t    <%.4f,%.4f,%.4f>\n",  C(1,1), C(1,3), C(1,2));
	fprintf(fn, "\t}\n");
endfunction

function viereck(fn, punkte)
	color = farbe(mean(punkte(:,1)), mean(punkte(:,2)));
	fprintf(fn, "    mesh {\n");
	dreieck(fn, punkte(1,:), punkte(2,:), punkte(3,:));
	dreieck(fn, punkte(2,:), punkte(3,:), punkte(4,:));
	fprintf(fn, "\tpigment { color rgb<%.4f,%.4f,%.4f> } // %.4f\n",
		color(1,1), color(1,2), color(1,3), color(1,4));
	fprintf(fn, "    }\n");
endfunction

fn = fopen("curvature.inc", "w");
punkte = zeros(4,3);
for ix = (0:xsteps)
	x = xmin + ix * hx;
	punkte(1,1) = x;      
	punkte(2,1) = x;
	punkte(3,1) = x + hx;
	punkte(4,1) = x + hx;
	for iy = (0:ysteps)
		y = ymin + iy * hy;
		punkte(1,2) = y;
		punkte(2,2) = y + hy;
		punkte(3,2) = y;
		punkte(4,2) = y + hy;
		for i = (1:4)
			punkte(i,3) = f(punkte(i,1), punkte(i,2));
		endfor
		viereck(fn, punkte);
	end
end
#fprintf(fn, "    finish { metallic specular 0.5 }\n");
fclose(fn);

printf("Cmax = %.4f\n", Cmax);
printf("Cmin = %.4f\n", Cmin);
