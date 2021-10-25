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
fprintf(f, "\\def\\punkte{\n");
for epsilon = (0.05:0.1:0.95)
	[k, e] = ellipke(epsilon^2);
	fprintf(f, "\\fill[color=blue] ({\\dx*%.4f},{\\dy*%.4f}) circle[radius=0.08];\n", epsilon, e);
	fprintf(f, "\\draw[color=blue,line width=0.2pt] ({\\dx*%.4f},{\\dy*%.4f}) -- ({\\dx*%.4f},{\\dy*1.85});\n", epsilon, e, epsilon);
endfor
fprintf(f,"}\n");
fclose(f);
