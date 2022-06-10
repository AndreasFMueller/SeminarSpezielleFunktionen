//
// common.inc -- 3d Darstellung
//
// (c) 2022 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
//
#version 3.7;
#include "colors.inc"
#include "../macros.inc"

global_settings {
	assumed_gamma 1
}

#declare imagescale = 0.034;

camera {
	location <40, 20, -20>
	look_at <0, 0.24, -0.20>
	right x * imagescale
	up y * imagescale
}

light_source {
	<30, 10, -40> color White
	area_light <1,0,0> <0,0,1>, 10, 10
	adaptive 1
	jitter
}

sky_sphere {
	pigment {
		color rgb<1,1,1>
	}
}

kugel(kugeldunkel)
achse(fein, White)
