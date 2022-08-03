# -*- coding: utf-8 -*-
"""
Created on Fri Jul 29 09:40:11 2022

@author: yanik
"""
import pylatex

import numpy as np
import matplotlib.pyplot as plt

N = np.array([0, 0])
V = np.array([1, 4])
Z = np.array([5, 5])
VZ = Z-V
vzScale = 0.4


a = [N, N, V]
b = [V, Z, vzScale*VZ]

X = np.array([i[0] for i in a])
Y = np.array([i[1] for i in a])
U = np.array([i[0] for i in b])
W = np.array([i[1] for i in b])

xlim = 6
ylim = 6
fig, ax = plt.subplots(1,1)
ax.set_xlim([0, xlim]) #<-- set the x axis limits
ax.set_ylim([0, ylim]) #<-- set the y axis limits
#plt.figure(figsize=(xlim, ylim))
ax.quiver(X, Y, U, W, angles='xy', scale_units='xy', scale=1, headwidth=5, headlength=7, headaxislength=5.5)

ax.plot([V[0], (VZ+V)[0]], [V[1], (VZ+V)[1]], 'k--')
ax.plot(np.vstack([V, Z])[:, 0], np.vstack([V, Z])[:,1], 'bo', markersize=10)


ax.text(2.5, 4.5, "Visierlinie", size=20, rotation=10)

plt.rcParams.update({
    "text.usetex": True,
    "font.family": "serif",
    "font.serif": ["New Century Schoolbook"],
})

ax.text(1.6, 4.3, r"$\vec{v}$", size=30)
ax.text(0.6, 3.9, r"$V$", size=30, c='b')
ax.text(5.1, 4.77, r"$Z$", size=30, c='b')



