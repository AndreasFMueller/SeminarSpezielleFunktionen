//
// position1.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
#include "common.inc"

union {
	seite(B, C, fett)
	punkt(A, fett)
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
	seite(A, P, fett)
	pigment {
		color rot
	}
	finish {
		specular 0.95
		metallic
	}
}


union {
	seite(A, B, fett)
	seite(A, C, fett)
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

object {
	winkel(A, B, C, fein, gross)
	pigment {
		color bekannt
	}
	finish {
		specular 0.95
		metallic
	}
}

object {
	winkel(A, P, C, fett, klein)
	pigment {
		color rot
	}
	finish {
		specular 0.95
		metallic
	}
}

