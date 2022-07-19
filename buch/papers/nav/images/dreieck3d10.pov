//
// dreiecke3d10.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#include "common.inc"

erde()

#declare Stern1 = Deneb;
#declare Stern2 = Spica;

koordinatennetz(gitterfarbe, 9, 0.001)

union {
	seite(A, Stern1, 0.5*fein)
	seite(A, Stern2, 0.5*fein)
	seite(A, Sakura, 0.5*fein)
	seite(Stern1, Sakura, 0.5*fein)
	seite(Stern2, Sakura, 0.5*fein)
	seite(Stern1, Stern2, 0.5*fein)

	punkt(A, fein)
	punkt(Sakura, fett)
	punkt(Deneb, fein)
	punkt(Spica, fein)
	punkt(Altair, fein)
	punkt(Arktur, fein)
	pigment {
		color Red
	}
}

//arrow(<-1.3,0,0>, <1.3,0,0>, fein, White)
arrow(<0,-1.3,0>, <0,1.3,0>, fein, White)
//arrow(<0,0,-1.3>, <0,0,1.3>, fein, White)

#declare imagescale = 0.044;

camera {
	location <40, 20, -20>
	look_at <0, 0.24, -0.20>
	right x * imagescale
	up y * imagescale
}

