//
// position3.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
#include "common.inc"

dreieck(B, P, C, kugelfarbe)

union {
	punkt(B, fett)
	punkt(C, fett)
	punkt(P, fett)
	pigment {
		color dreieckfarbe
	}
	finish {
		specular 0.95
		metallic
	}
}

union {
	seite(B, C, fett)
	seite(B, P, fett)
	seite(C, P, fett)
	pigment {
		color bekannt
	}
	finish {
		specular 0.95
		metallic
	}
}

union {
	winkel(B, P, C, fein, gross)
	winkel(C, B, P, fein, gross)
	pigment {
		color unbekannt
	}
	finish {
		specular 0.95
		metallic
	}
}

