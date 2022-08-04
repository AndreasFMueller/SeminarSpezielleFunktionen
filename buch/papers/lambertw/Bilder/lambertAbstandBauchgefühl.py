# -*- coding: utf-8 -*-
"""
Created on Sun Jul 31 13:32:53 2022

@author: yanik
"""

import numpy as np
import matplotlib.pyplot as plt
import scipy.special as sci

W = sci.lambertw


t = np.linspace(0, 1.2, 1000)
x0 = 1
y0 = 1

r0 = np.sqrt(x0**2+y0**2)
chi = (r0+y0)/(r0-y0)

x = x0*np.sqrt(1/chi*W(chi*np.exp(chi-4*t/(r0-y0))))
eta = (x/x0)**2
y = 1/4*((y0+r0)*eta+(y0-r0)*np.log(eta)-r0+3*y0)

ymin= (min(y)).real
xmin = (x[np.where(y == ymin)][0]).real


#Verfolger
plt.plot(x, y, 'r--')
plt.plot(xmin, ymin, 'bo', markersize=10)

#Ziel
plt.plot(np.zeros_like(t), t, 'g--')
plt.plot(0, ymin, 'bo', markersize=10)


plt.plot([0, xmin], [ymin, ymin], 'k--')
#plt.xlim(-0.1, 1)
#plt.ylim(1, 2)
plt.ylabel("y")
plt.xlabel("x")
plt.grid(True)
plt.quiver(xmin, ymin, -0.2, 0, scale=1)

plt.text(xmin+0.1, ymin-0.1, "Verfolgungskurve", size=20, rotation=20, color='r')
plt.text(0.01, 0.02, "Fluchtkurve", size=20, rotation=90, color='g')

plt.rcParams.update({
    "text.usetex": True,
    "font.family": "serif",
    "font.serif": ["New Century Schoolbook"],
})

plt.text(xmin-0.11, ymin-0.08, r"$\dot{v}$", size=20)
plt.text(xmin-0.02, ymin+0.05, r"$V$", size=20, c='b')
plt.text(0.02, ymin+0.05, r"$Z$", size=20, c='b')