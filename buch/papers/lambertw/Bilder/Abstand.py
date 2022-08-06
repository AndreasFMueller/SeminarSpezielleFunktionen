# -*- coding: utf-8 -*-
"""
Created on Sat Jul 30 23:09:33 2022

@author: yanik
"""

import numpy as np
import matplotlib.pyplot as plt

phi = np.pi/2
t = np.linspace(0, 10, 10**5)
x0 = 1

def D(t):
    return np.sqrt(x0**2+2*x0*t*np.cos(phi)+2*t**2-2*t**2*np.sin(phi))

plt.plot(t, D(t))
