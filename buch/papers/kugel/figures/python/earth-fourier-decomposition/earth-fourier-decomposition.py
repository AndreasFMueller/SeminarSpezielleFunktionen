# -*- coding: utf-8 -*-
"""
date of creation: Tue Aug 30 16:21:15 2022
-------------------------------------------------
@author : Manuel Cattaneo
@contact: cattaneo.manuel@hotmail.com
-------------------------------------------------    

Description:
    -

Modules:
"""
import pyshtools as pysh

import plotly.graph_objects as go
from plotly.subplots import make_subplots

import numpy as np

import plotly.io as pio
pio.renderers.default = 'browser'
"""
------------------------------------------------------------------------------
"""
def coeffs2function(coeffs):
    return pysh.expand.MakeGridDH(coeffs, sampling=1, norm=4)

def filter_coeffs(coeffs: np.ndarray, l_max: int):
    l_max = int(l_max)
    out = np.copy(coeffs)
    out[:,l_max:,:] = 0.0
    return out

def sph2cart(r, theta, phi):
    r = np.abs(r)
    x = r*np.cos(theta)*np.sin(phi)
    y = r*np.sin(phi)  *np.sin(theta)
    z = r              *np.cos(phi)
    
    return x,y,z

if __name__ == '__main__':
    ## ***********************************************************************
    ## To change "resolution" of reconstruction ******************************
    n_cut = 1000 # Max resolution is 2000 (N-2)
    ## ***********************************************************************
    ## ***********************************************************************

    FONTSIZE_TITLE = 70
    
    N = 2002
    
    # Create grid
    theta, phi = np.meshgrid(np.linspace(-np.pi, np.pi, N), # theta in [0, 2pi]
                             np.linspace(0,      np.pi, N))
    
    # Get GOCE coeffs
    earth_coeff = pysh.datasets.Earth.Earth2014.tbi(lmax=(N-2)//2).coeffs
    
    # Filter coeffs and transform to get cartesian coordinate system
    coeff  = filter_coeffs(earth_coeff, n_cut)
    r       = coeffs2function(coeff)/1000. + 75
    x, y, z = sph2cart(r, theta, phi)
   
    # Create surface
    surface = go.Surface(z=z, x=x, y=y,
                         colorscale='Viridis',
                         surfacecolor=r,
                         showscale=False)
   
    fig = go.Figure(data=[surface])  
    
    # Set the camera to a default position (should not be changed)
    camera = dict\
    (
        up=dict(x=0, y=0, z=1),center=dict(x=0, y=0, z=0),
        eye=dict(x=-1*1.05, y=-0.5*1.05, z=0.4*1.05)
    )

    # Plot surface and set title + font
    fig.update_layout\
    ( 
        scene_camera=camera,
        title = dict\
            (
                text=f"n={n_cut}",
                y=1.0,
                x=0.5,
                font=dict(family="Computer Modern", size=FONTSIZE_TITLE, color='black'),
                xanchor='center',
                yanchor='top'
            )
    )
    
    # Remove all axis 
    fig.update_scenes\
    (
        xaxis_visible=False, 
        yaxis_visible=False,
        zaxis_visible=False 
    )
    
    fig.show()
    
