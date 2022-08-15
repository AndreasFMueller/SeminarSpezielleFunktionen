# -*- coding: utf-8 -*-
"""
Created on Sun Jul 31 14:34:13 2022

@author: yanik
"""

import numpy as np
import matplotlib.pyplot as plt

t = 0
phi = np.linspace(np.pi/2, 3*np.pi/2, 10**5)
x0 = 1
y0 = -2

def D(t):
    return (x0+t*np.cos(phi))*np.cos(phi)+(y0+t*(np.sin(phi)-1))*(np.sin(phi)-1)/(np.sqrt((x0+t*np.cos(phi))**2+(y0+t*(np.sin(phi)-1))**2))


plt.plot(phi, D(t))