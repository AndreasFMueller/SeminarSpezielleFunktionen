%
% t.m -- Berechnung der Tschebyscheff-Polynome mit der Rekursionsformel
%
% (c) 2022 Prof Dr Andreas Müller
%
N = 100000

A = zeros(N+1,11);
A(1,:) = ones(1,11);
A(2,:) = (0:10) / 10;

B = A;

for n = (2:N)
	A(n+1,:) = 2 * A(2,:) .* A(n,:) - A(n-1,:);
	for i = (1:11)
		B(n+1,i) = cos(n*acos(B(2,i)));
	end
end

F = B - A;

i = 1;
l = 0;
fn = fopen("tschdata.tex", "w");
while i < N + 1
	A(i+1,:)
	B(i+1,:)
	F(i+1,:)
	fprintf(fn, "%% i = %d\n", i);
	fprintf(fn, "%d & %18.14f & %18.14f & %18.14f \\\n", l,
		A(i+1, 2),
		A(i+1, 5),
		A(i+1, 9));
	fprintf(fn, "%d & %18.14f & %18.14f & %18.14f \\\n", l,
		F(i+1, 2),
		F(i+1, 5),
		F(i+1, 9));
	fprintf(fn, "%d & %18.14f & %18.14f & %18.14f \\\n", l,
		B(i+1, 2),
		B(i+1, 5),
		B(i+1, 9));
	i = i * 10;
	l = l + 1;
end

fclose(fn);
