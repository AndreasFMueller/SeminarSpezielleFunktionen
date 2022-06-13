//
// position5.pov
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
#include "common.inc"

dreieck(A, P, C, kugelfarbe)

union {
	punkt(A, fett)
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
		color unbekannt
	}
	finish {
		specular 0.95
		metallic
	}
}


union {
	seite(A, C, fett)
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
	winkel(C, P, A, fein, gross)
	pigment {
		color bekannt
	}
	finish {
		specular 0.95
		metallic
	}
}

object {
	winkel(A, C, P, fein, gross)
	pigment {
		color unbekannt
	}
	finish {
		specular 0.95
		metallic
	}
}

