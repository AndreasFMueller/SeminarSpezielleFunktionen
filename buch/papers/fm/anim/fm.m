#
# fm.m -- animation frequenzspektrum
#
# (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
global fc;
fc = 1e6;
global width;
width = 16;
global fm;
fm = 1000;
global gamma;
gamma = 2;
global resolution;
resolution = 300;

function retval = spektrum(beta, fm)
	global width;
	global fc;
	retval = zeros(2 * width + 1, 2);
	center = width + 1;
	for k = (0:width)
		retval(center - k, 1) = fc - k * fm;
		retval(center + k, 1) = fc + k * fm;
		a = besselj(k, beta);
		retval(center - k, 2) = a;
		retval(center + k, 2) = a;
	endfor
endfunction

function drawspectrum(fn, spectrum, foffset, fscale, beta)
	n = size(spectrum)(1,1);
	for i = (1:n)
		f = (spectrum(i, 1) - foffset)/fscale;
		a = log10(spectrum(i, 2)) + 6;
		if (a < 0) 
			a = 0;
		end
		fprintf(fn, "\\draw[line width=3.5pt] ");
		fprintf(fn, "({%.2f*\\df},0) -- ({%.2f*\\df},{%.5f*\\da});\n",
			f, f, abs(a));
		fprintf(fn, "\\node at ({-15*\\df},5.5) [right] {$\\beta = %.3f$};", beta);
	endfor
endfunction

function drawhull(fn, beta)
	global resolution;
	fprintf(fn, "\\begin{scope}\n");
	fprintf(fn, "\\clip ({-16.5*\\df},0) rectangle ({16.5*\\df},{6*\\da});\n");
	p = zeros(resolution, 2);
	for k = (1:resolution)
		nu = 16.5 * (k - 1) / resolution;
		p(k,1) = nu;
		y = log10(abs(besselj(nu, beta))) + 6;
		p(k,2) = y;
	end
	fprintf(fn, "\\draw[color=blue] ({%.4f*\\df},{%.5f*\\da})",
		p(1,1), p(1,2));
	for k = (2:resolution)
		fprintf(fn, "\n    -- ({%.4f*\\df},{%.5f*\\da})",
			p(k,1), p(k,2));
	endfor
	fprintf(fn, ";\n\n");
	fprintf(fn, "\\draw[color=blue] ({%.4f*\\df},{%.5f*\\da})",
		p(1,1), p(1,2));
	for k = (2:resolution)
		fprintf(fn, "\n    -- ({%.4f*\\df},{%.5f*\\da})",
			-p(k,1), p(k,2));
	endfor
	fprintf(fn, ";\n\n");
	fprintf(fn, "\\end{scope}\n");
endfunction

function animation(betamin, betamax, steps)
	global fm;
	global fc;
	global gamma;
	fa = fopen("parts.tex", "w");
	for k = (1:steps)
		% add entry to parts.tex
		fprintf(fa, "\\spektrum{%d}{texfiles/a%04d.tex}\n", k, k);
		% compute beta
		x = (k - 1) / (steps - 1);
		beta = betamin + (betamax - betamin) * (x ^ gamma);
		% create a new file
		name = sprintf("texfiles/a%04d.tex", k);
		fn = fopen(name, "w");
		% write the hull
		drawhull(fn, beta);
		% compute and write the spectrum
		spectrum = spektrum(beta, fm);
		drawspectrum(fn, spectrum, fc, fm, beta);
		fclose(fn);
	endfor
	fclose(fa);
endfunction

animation(0.001,10.1,200)
