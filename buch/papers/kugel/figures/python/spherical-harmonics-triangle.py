# -*- coding: utf-8 -*-
"""
date of creation: Fri Mar 25 16:20:46 2022
-------------------------------------------------
@author : Manuel Cattaneo
@contact: cattaneo.manuel@hotmail.com
-------------------------------------------------    

Description:
    Program used to play around with the spherical harmonics.

Modules:
"""
import numpy as np
# plot stuff
import matplotlib.pyplot as plt
import mpl_toolkits.mplot3d.axes3d as axes3d  # to plot 3d
import matplotlib.gridspec as gs              # for grid layout
plt.rcParams.update({
    "text.usetex": True,
    "font.family": "serif",
    "font.serif": ["Times"],
})
# spherical harmonics
from scipy.special import sph_harm
"""
------------------------------------------------------------------------------
"""

def main(row):
    # grid spec
    col       = 2*row-1                     
    grid_spec = gs.GridSpec(row, col, wspace=.05, hspace=0)
    fig       = plt.figure(figsize=(18 / 2.54, 15 / 2.54))
    
    # creating spherical domain
    N = 70
    theta, phi = np.meshgrid(np.linspace(0, 2*np.pi, N),  # theta in [0, 2pi]
                             np.linspace(0,   np.pi, N))  # phi   in [0,  pi]
    
    # m < n(=l)
    for n in range(0,row):
        for i, m in enumerate(range(-n, n+1)):
            # real(...) to obtain only the cos(.) part. This is done in order   
            # to have the same functions as the ones at p.518 chapter 12.2.
            if m >= 0:
                r = np.abs(sph_harm(m, n, theta, phi).real) # Y_n^m 
                # r = sph_harm(m, n, theta, phi).real
            else:
                r = np.abs(sph_harm(-m, n, theta, phi).imag)
                # r = sph_harm(m, n, theta, phi).imag
                
            # coordinates transformation
            x = r*np.cos(theta)*np.sin(phi)
            y = r*np.sin(phi)  *np.sin(theta)
            z = r              *np.cos(phi)
            
            # adding subplot
            ax = fig.add_subplot(grid_spec[n,col//2+m], projection='3d')
            ax.set_axis_off()
            ax.set_title(fr'\small $Y_{{{n}}}^{{{m}}}$')

            # plot
            plot = ax.plot_surface(x, y, z, #facecolors = fc,
                                    cmap='viridis',  
                                    linewidth=0,
                                    antialiased=False)#, cstride=1, rstride=10)
    plt.show()
    fig.savefig("spherical-harmonics-triangle.pdf", bbox_inches="tight")

'''
************************** Select how many row you want your triangle to have
******************************************************************************
'''
row = 6
'''
******************************************************************************
******************************************************************************
'''

if __name__ == '__main__':
    main(row) 
    
