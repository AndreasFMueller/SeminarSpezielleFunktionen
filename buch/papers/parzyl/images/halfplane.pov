//
// 3dimage.pov
//
// (c) 2022 Prof Dr Andreas Müller
//
#version 3.7;
#include "colors.inc"
#include "skies.inc"
#include "common.inc"

global_settings {
        assumed_gamma 1
}

#declare imagescale = 0.63;
#declare ar = 0.02;

#declare Cameracenter = <5,3,-4>;
#declare Worldpoint = <0,-0.80, 0>;
#declare Lightsource = < 7,10,-3>;
#declare Lightdirection = vnormalize(Lightsource - Worldpoint);
#declare Lightaxis1 = vnormalize(vcross(Lightdirection, <0,1,0>));
#declare Lightaxis2 = vnormalize(vcross(Lightaxis1, Lightdirection));

camera {
	location Cameracenter
	look_at Worldpoint
	right 16/9 * x * imagescale
	up y * imagescale
}

light_source {
	Lightsource color White
	area_light Lightaxis1 Lightaxis2, 10, 10
	adaptive 1
	jitter
}

sky_sphere {
	pigment {
		color White
	}
}

arrow( <-2.1, 0,   0 >, < 2.2, 0,   0 >, ar, White)
arrow( < 0,  -1.1, 0 >, < 0, 1.3, 0 >, ar, White)
arrow( < 0,   0,  -2 >, < 0, 0,   2.2 >, ar, White)

#declare planecolor = rgb<0.2,0.6,1.0>;
#declare r = 0.01;

#macro planebox()
	box { <-2.1,-1.1,-2.1>, <0,1.1,2.1> }
#end

intersection {
	plane { <0, 0,  1>, 0.001 }
	plane { <0, 0, -1>, 0.001 }
	planebox()
	pigment {
		color planecolor transmit 0.3
	}
	finish {
		metallic
		specular 0.95
	}
}

#declare Xstep = 0.2;

intersection {
	union {
		#declare X = 0;
		#while (X > -2.5)
			cylinder { <X,-3,0>, <X,+3,0>, r }
			#declare X = X - Xstep;
		#end

		#declare Y = Xstep;
		#while (Y < 2.5)
			cylinder { <-3,  Y, 0>, <0,  Y, 0>, r }
			cylinder { <-3, -Y, 0>, <0, -Y, 0>, r }
			#declare Y = Y + Xstep;
		#end
	}
	planebox()
	pigment {
		color planecolor
	}
	finish {
		metallic
		specular 0.95
	}
}

#declare parammin = -4;
#declare parammax = 4;
#declare paramsteps = 100;
#declare paramstep = (parammax - parammin) / paramsteps;

#macro punkt(sigma, tau, Z)
	<
		0.5 * (tau*tau - sigma*sigma)
		Z,
		sigma * tau,
	>
#end

#macro sigmasurface(sigma, farbe)
	#declare taumin1 = 2/sigma;
	#declare taumin2 = sqrt(4+sigma*sigma);
	#if (taumin1 > taumin2)
		#declare taumin = -taumin2;
	#else
		#declare taumin = -taumin1;
	#end
	
	mesh {
		#declare tau = taumin;
		#declare taumax = -taumin;
		#declare taustep = (taumax - taumin) / paramsteps;
		#while (tau < taumax - taustep/2)
			triangle {
				punkt(sigma, tau,           -1),
				punkt(sigma, tau,            0),
				punkt(sigma, tau + taustep, -1)
			}
			triangle {
				punkt(sigma, tau + taustep, -1),
				punkt(sigma, tau + taustep,  0),
				punkt(sigma, tau,            0)
			}
			#declare tau = tau + taustep;
		#end
		pigment {
			color farbe
		}
		finish {
			specular 0.9
			metallic
		}
	}

	union {
		#declare tau = taumin;
		#declare taumax = -taumin;
		#declare taustep = (taumax - taumin) / paramsteps;
		#while (tau < taumax - taustep/2)
			sphere { punkt(sigma, tau, 0), r }
			cylinder {
				punkt(sigma, tau,           0),
				punkt(sigma, tau + taustep, 0),
				r
			}
			#declare tau = tau + taustep;
		#end
		sphere { punkt(sigma, tau, 0), r }
		pigment {
			color farbe
		}
		finish {
			specular 0.9
			metallic
		}
		
	}
#end

#declare greensurfacecolor = rgb<0.6,1.0,0.6>;
#declare redsurfacecolor = rgb<1.0,0.6,0.6>;

sigmasurface(0.25, greensurfacecolor)
sigmasurface(0.5,  greensurfacecolor)
sigmasurface(0.75, greensurfacecolor)
sigmasurface(1,    greensurfacecolor)
sigmasurface(1.25, greensurfacecolor)
sigmasurface(1.5,  greensurfacecolor)
sigmasurface(1.75, greensurfacecolor)
sigmasurface(2,    greensurfacecolor)

union {
	sigmasurface(0.25, redsurfacecolor)
	sigmasurface(0.5,  redsurfacecolor)
	sigmasurface(0.75, redsurfacecolor)
	sigmasurface(1.00, redsurfacecolor)
	sigmasurface(1.25, redsurfacecolor)
	sigmasurface(1.5,  redsurfacecolor)
	sigmasurface(1.75, redsurfacecolor)
	sigmasurface(2,    redsurfacecolor)
	rotate <0, 180, 0>
}

box { <-2,-1,-2>, <2,-0.99,2> 
	pigment {
		color rgb<1.0,0.8,0.6> transmit 0.8
	}
	finish {
		specular 0.9
		metallic
	}
}
