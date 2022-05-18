#
# pk.m -- Punkte und Kanten für sphärisches Dreieck
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#

A = [  1, 8 ];
B = [ -3, 3 ];
C = [  4, 4 ];
P = [  0, 0 ];

global fn;
fn = fopen("dreieckdata.tex", "w");

fprintf(fn, "\\coordinate (P) at (%.4f,%.4f);\n", P(1,1), P(1,2));
fprintf(fn, "\\coordinate (A) at (%.4f,%.4f);\n", A(1,1), A(1,2));
fprintf(fn, "\\coordinate (B) at (%.4f,%.4f);\n", B(1,1), B(1,2));
fprintf(fn, "\\coordinate (C) at (%.4f,%.4f);\n", C(1,1), C(1,2));

function retval = seite(A, B, l, nameA, nameB)
	global fn;
	d = fliplr(B - A);
	d(1, 2) = -d(1, 2);
	# Zentrum
	C = 0.5 * (A + B) + l * d;
	# Radius:
	r = hypot(C(1,1)-A(1,1), C(1,2)-A(1,2))
	# Winkel von
	winkelvon = atan2(A(1,2)-C(1,2),A(1,1)-C(1,1));
	# Winkel bis
	winkelbis = atan2(B(1,2)-C(1,2),B(1,1)-C(1,1));
	if (abs(winkelvon - winkelbis) > pi)
		if (winkelbis < winkelvon)
			winkelbis = winkelbis + 2 * pi
		else
			winkelvon = winkelvon + 2 * pi
		end
	end
	# Kurve
	fprintf(fn, "\\def\\kante%s%s{(%.4f,%.4f) arc (%.5f:%.5f:%.4f)}\n",
		nameA, nameB,
		A(1,1), A(1,2), winkelvon * 180 / pi, winkelbis * 180 / pi, r);
	fprintf(fn, "\\def\\kante%s%s{(%.4f,%.4f) arc (%.5f:%.5f:%.4f)}\n",
		nameB, nameA,
		B(1,1), B(1,2), winkelbis * 180 / pi, winkelvon * 180 / pi, r);
endfunction

seite(A, B, -1, "A", "B");
seite(A, C, 1, "A", "C");
seite(A, P, -1, "A", "P");
seite(B, C, -2, "B", "C");
seite(B, P, -1, "B", "P");
seite(C, P, 2, "C", "P");

fclose(fn);
