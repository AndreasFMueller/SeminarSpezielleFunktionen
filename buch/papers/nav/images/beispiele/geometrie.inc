union {
	punkt(A, fett)
	punkt(Stern1, fein)
	punkt(Stern2, fein)
	seite(Stern1, Stern2, fein)
	pigment {
		color kugelfarbe
	}
	finish {
		metallic
		specular 0.9
	}
}

union {
	seite(A, Stern1, fein)
	seite(A, Stern2, fein)
	seite(Stern1, Sakura, fein)
	seite(Stern2, Sakura, fein)
	winkel(A, Stern1, Stern2, 0.5*fein, gross)
	pigment {
		color bekannt
	}
	finish {
		metallic
		specular 0.9
	}
}

union {
	seite(A, Sakura, fein)
	winkel(A, Sakura, Stern1, 0.5*fett, klein)
	pigment {
		color unbekannt
	}
	finish {
		metallic
		specular 0.9
	}
}

