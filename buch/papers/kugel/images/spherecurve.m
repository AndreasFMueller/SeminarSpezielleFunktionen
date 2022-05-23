#
# spherecurv.m
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
global a;
a = 5;
global A;
A = 10;

phisteps = 400;
hphi = 2 * pi / phisteps;
thetasteps = 200;
htheta = pi / thetasteps;

function retval = f(z)
	global a;
	global A;
	retval = A * exp(a * (z^2 - 1));
endfunction

function retval = g(z)
	global a;
	retval = -f(z) * 2 * a * (2 * a * z^4 + (3 - 2*a) * z^2 - 1);
	#                                                              2
	#                   - a     2  4             2   2          a z
	#(%o6)          - %e    (4 a  z  + (6 a - 4 a ) z  - 2 a) %e
endfunction

phi = (1 + sqrt(5)) / 2;

global axes;
axes = [
     0,   0,   1,  -1, phi, -phi;
     1,  -1, phi, phi,   0,    0;
   phi, phi,   0,   0,   1,    1;
];
axes = axes / (sqrt(phi^2+1));

function retval = kugel(theta, phi)
	retval = [
	    cos(phi) * sin(theta);
	    sin(phi) * sin(theta);
	               cos(theta)
	];
endfunction

function retval = F(v)
	global axes;
	s = 0;
	for i = (1:6)
		z = axes(:,i)' * v;
		s = s + f(z);
	endfor
	retval = s / 6;
endfunction

function retval = F2(theta, phi)
	v = kugel(theta, phi);
	retval = F(v);
endfunction

function retval = G(v)
	global axes;
	s = 0;
	for i = (1:6)
		s = s + g(axes(:,i)' * v);
	endfor
	retval = s / 6;
endfunction

function retval = G2(theta, phi)
	v = kugel(theta, phi);
	retval = G(v);
endfunction

function retval = cnormalize(u)
	utop = 11;
	ubottom = -30;
	retval = (u - ubottom)  / (utop - ubottom);
	if (retval > 1) 
		retval = 1;
	endif
	if (retval < 0)
		retval = 0;
	endif
endfunction

global umin;
umin = 0;
global umax;
umax = 0;

function color = farbe(v)
	global umin;
	global umax;
	u = G(v);
	if (u < umin) 
		umin = u;
	endif
	if (u > umax)
		umax = u;
	endif
	u = cnormalize(u);
	color = [ u, 0.5, 1-u ];
	color = color/max(color);
endfunction

function dreieck(fn, v0, v1, v2)
	fprintf(fn, "    mesh {\n");
	c = (v0 + v1 + v2) / 3;
	c = c / norm(c);
	color = farbe(c);
	v0 = v0 * (1 + F(v0));
	v1 = v1 * (1 + F(v1));
	v2 = v2 * (1 + F(v2));
	fprintf(fn, "\ttriangle {\n");
	fprintf(fn, "\t    <%.6f,%.6f,%.6f>,\n", v0(1,1), v0(3,1), v0(2,1));
	fprintf(fn, "\t    <%.6f,%.6f,%.6f>,\n", v1(1,1), v1(3,1), v1(2,1));
	fprintf(fn, "\t    <%.6f,%.6f,%.6f>\n",  v2(1,1), v2(3,1), v2(2,1));
	fprintf(fn, "\t}\n");
	fprintf(fn, "\tpigment { color rgb<%.4f,%.4f,%.4f> }\n",
		color(1,1), color(1,2), color(1,3));
	fprintf(fn, "\tfinish { metallic specular 0.5 }\n");
	fprintf(fn, "    }\n");
endfunction

fn = fopen("spherecurve.inc", "w");

	for i = (1:phisteps)
		# Polkappe nord
		v0 = [ 0; 0; 1 ];
		v1 = kugel(htheta, (i-1) * hphi);
		v2 = kugel(htheta,  i    * hphi);
		fprintf(fn, "    // i = %d\n", i);
		dreieck(fn, v0, v1, v2);

		# Polkappe sued
		v0 = [ 0; 0; -1 ];
		v1 = kugel(pi-htheta, (i-1) * hphi);
		v2 = kugel(pi-htheta,  i    * hphi);
		dreieck(fn, v0, v1, v2);
	endfor

	for j = (1:thetasteps-2)
		for i = (1:phisteps)
			v0 = kugel( j    * htheta, (i-1) * hphi);
			v1 = kugel((j+1) * htheta, (i-1) * hphi);
			v2 = kugel( j    * htheta,  i    * hphi);
			v3 = kugel((j+1) * htheta,  i    * hphi);
			fprintf(fn, "    // i = %d, j = %d\n", i, j);
			dreieck(fn, v0, v1, v2);
			dreieck(fn, v1, v2, v3);
		endfor
	endfor

fclose(fn);

umin
umax
