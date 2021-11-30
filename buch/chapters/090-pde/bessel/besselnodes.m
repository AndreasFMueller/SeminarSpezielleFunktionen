#
# besselnodes.m
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
global maxmu;
maxmu = 3;
global maxk;
maxk = 4;
global mu;

nachkommastellen = 4;

function retval = f(x)
	global mu;
	retval = besselj(mu, x);
endfunction

global kzeros;
kzeros = zeros(maxk+1, maxmu+1);
for mu = (0:maxmu)
	k = 0;
	x = 0.0001;
	while (k <= maxk)
		bracket = [ x, x+1 ];
		if (f(bracket(1)) * f(bracket(2)) < 0) 
			kzeros(k+1,mu+1) = fzero("f", bracket);
			k = k + 1;
		endif
		x = x + 1;
	endwhile
endfor

xshift = 4;
yshift = 4;
global	r;
r = 1.8;

function	retval = anderefarbe(f)
	if (1 == strcmp("red", f))
		retval = "blue";
	else
		retval = "red";
	endif
endfunction

function sektor(fn, mu, k, w0, w1, startfarbe)
	global	kzeros;
	global 	r;
	fprintf(fn, "\\begin{scope}\n");
	fprintf(fn, "\\clip (0,0)--(%.4f:%.4f) arc (%.4f:%.4f:%.4f)--cycle;\n",
		w0, r, w0, w1, r);
	faktor = kzeros(k+1,mu+1);

	K = k + 1;
	farbe = startfarbe;
	while (K > 0)
		R = r * kzeros(K, mu+1) / faktor;
		fprintf(fn, "\\fill[color=%s!20] ", farbe);
		fprintf(fn, "(0,0) circle[radius=%.4f];\n", R);
		farbe = anderefarbe(farbe);
		K = K-1;
	end
	fprintf(fn, "\\end{scope}\n");
endfunction

fn = fopen("besselnodes.tex", "w");

#fprintf(fn, "\\begin{tikzpicture}[>=latex,thick]\n");

for mu = (0:maxmu)
	if (mu > 0)
		winkel = 180 / mu;
	else
		winkel = 360;
	endif
	for k = (0:maxk)
		fprintf(fn, "\\begin{scope}[xshift=%.3fcm,yshift=-%.3fcm]\n",
			mu * xshift, k * yshift);
		for w0 = (0:2*winkel:360)
			sektor(fn, mu, k, w0, w0 + winkel, "red");
			if (winkel < 270)
				sektor(fn, mu, k, w0 + winkel, w0 + 2 * winkel, "blue");
			endif
		endfor

		fprintf(fn, "\\draw (0,0) circle[radius=%.4f];\n", r);

		fprintf(fn, "\\end{scope}\n\n");
	endfor
endfor

for mu = (0:maxmu)
	fprintf(fn, "\\node at (%.4f,%.4f) [above] {$\\mu=%d$};\n",
		mu * xshift, 0.5 * yshift, mu);
endfor

for k = (0:maxk)
	fprintf(fn, "\\node at (%.4f,%.4f) [above,rotate=90] {$k=%d$};\n",
		-0.5 * xshift, -k * yshift, k);
endfor

#fprintf(fn, "\\end{tikzpicture}\n");

fclose(fn);

