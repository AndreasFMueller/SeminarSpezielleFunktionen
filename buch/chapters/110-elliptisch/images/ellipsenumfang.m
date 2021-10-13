#
# ellipsenumfang
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
f = fopen("ekplot.tex", "w");
fprintf(f, "\\def\\ekpath{\n");
fprintf(f, "(0,{\\dy*%.4f})\n", pi / 2);
for epsilon = (1:100) / 100
	[k, e] = ellipke(epsilon^2);
	fprintf(f, "--({\\dx*%.4f},{\\dy*%.4f})\n", epsilon, e);
endfor
fprintf(f, "\n}\n");
fclose(f);
