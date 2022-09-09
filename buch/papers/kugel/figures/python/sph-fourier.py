# -*- coding: utf-8 -*-
"""
date of creation: Fri Mar 10 03:20:46 2022
-------------------------------------------------
@author : Manuel Cattaneo
@contact: cattaneo.manuel@hotmail.com
-------------------------------------------------    

Description:
    Program to generate a random spherical functions with its spectrum

Modules:
"""
import numpy as np
import pyshtools as pysh

from matplotlib import rc
import matplotlib.pylab as plt

rc('font', **{'family': 'serif', 'serif': ['Computer Modern']})
rc('text', usetex=True)
"""
------------------------------------------------------------------------------
"""
## Coordinates transformation ------------------------------------------------
## ---------------------------------------------------------------------------

def sph2cart(r, theta, phi):
    r = np.abs(r)
    x = r*np.cos(theta)*np.sin(phi)
    y = r*np.sin(phi)  *np.sin(theta)
    z = r              *np.cos(phi)
    
    return x,y,z

def cart2sph(x,y,z):
    x, y, z = x.astype(np.float64), y.astype(np.float64), z.astype(np.float64)
    
    r          = np.linalg.norm( np.vstack([x,y,z]).T , axis=1 )
    theta, phi = np.arctan2(y,x), np.arccos(z/r)
    
    return r, theta, phi

## Series expansion ----------------------------------------------------------
## ---------------------------------------------------------------------------
## norm = 4 -> orthonormal harmonics

def function2coeffs(function):
    return pysh.expand.SHExpandDH(function, sampling=1, norm=4)

def coeffs2function(coeffs):
    return pysh.expand.MakeGridDH(coeffs, sampling=1, norm=4)

def filter_coeffs(coeffs: np.ndarray, l_max: int):
    out = np.copy(coeffs)
    out[:,l_max:,:] = 0.0
    return out
    
## ---------------------------------------------------------------------------
## ---------------------------------------------------------------------------

def get_spectrum(coeffs,length):
    N = coeffs.shape[2]
    coeffs_2plot = np.zeros(shape=(length,N*2-1))
    coeffs_2plot[:,:N-1] = np.fliplr(coeffs[1,:length,1:])
    coeffs_2plot[:,N-1:] = coeffs[0,:length,:]
    coeffs_2plot[coeffs_2plot == 0] = np.nan
    coeffs_2plot = np.flipud(coeffs_2plot)
    
    return coeffs_2plot[:length,N-length:N+length-1]


if __name__ == '__main__':
    FONTSIZE_TICK  = 25
    FONTSIZE_LABEL = 30
    

    N = 52 
    power    = np.arange(N, dtype=float)
    power[0] = 99999 # or np.inf
    power    = power**(-2)
    
    clm = pysh.SHCoeffs.from_random(power, seed=12345)
    f   = coeffs2function(clm.coeffs) 
    
    theta, phi = np.meshgrid(np.linspace(0, 2*np.pi, N*2), # theta in [0, 2pi]
                             np.linspace(0,   np.pi, N*2))
    r = f
    x,y,z = sph2cart(r, theta, phi)
    
    fig = plt.figure()
    # Adjust whole fig
    fig.subplots_adjust(top=1.0,
                        bottom=0.0,
                        left=0.0,
                        right=0.93,
                        hspace=0.2,
                        wspace=0.155)
    
    # Create 3d and 2d axis
    ax_3d = fig.add_subplot(1,2,1, projection='3d')
    ax_2d = fig.add_subplot(1,2,2)
    
    # Ax for spherical function plot
    ax_3d.plot_surface(
        x, y, z, rstride=1, cstride=1, cmap=plt.get_cmap('summer'),
        linewidth=0, antialiased=False, alpha=0.5)
    
    ax_3d.set_axis_off()
    
    ax_3d.set_ylim([-0.6,0.52])
    ax_3d.set_xlim([-0.48, 0.43])
    ax_3d.set_zlim([-0.3,0.3])
    ax_3d.view_init(elev=90., azim=-100)
    
    # Ax for spectrum triangle
    spectrum    = get_spectrum(np.log10(np.abs(clm.coeffs)*20), length=N//2)
    spectrum_im = ax_2d.imshow(spectrum, interpolation='none', cmap=plt.get_cmap('summer'))

    ax_2d.set_xlabel('Order $m$', 
                     fontsize=FONTSIZE_LABEL)
    ax_2d.set_ylabel('Degree $n$', 
                     fontsize=FONTSIZE_LABEL)
    ax_2d.tick_params(labelsize=FONTSIZE_TICK)
    
    # Color bar
    cbar = plt.colorbar(spectrum_im, aspect=10, fraction=0.05, pad=0.07)
    cbar.ax.tick_params(labelsize=FONTSIZE_TICK)

    
    

