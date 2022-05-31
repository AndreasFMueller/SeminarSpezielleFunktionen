#!/usr/bin/env python3
# -*- coding:utf-8 -*-
"""Plot for integrand of gamma function with shifting terms."""

import os
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

EPSILON = 1e-12
xlims = np.array([-3, 3])

root = str(Path(__file__).parent)
img_path = f"{root}/../images"
os.makedirs(img_path, exist_ok=True)

t = np.logspace(*xlims, 1001)[:, None]

z = np.array([-4.5, -2, -1, -0.5, 0.0, 0.5, 1, 2, 4.5])
r = t ** z

fig, ax = plt.subplots(num=1, clear=True, constrained_layout=True, figsize=(5, 3))
ax.semilogx(t, r)
ax.set_xlim(*(10.0 ** xlims))
ax.set_ylim(1e-3, 40)
ax.set_xlabel(r"$x$")
ax.set_ylabel(r"$x^z$")
ax.grid(1, "both")
labels = [f"$z={zi: 3.1f}$" for zi in np.squeeze(z)]
ax.legend(labels, ncol=2, loc="upper left", fontsize="small")
fig.savefig(f"{img_path}/integrands.pgf")

z2 = np.array([-1, -0.5, 0.0, 0.5, 1, 2, 3, 4, 4.5])
e = np.exp(-t)
r2 = t ** z2 * e

fig2, ax2 = plt.subplots(num=2, clear=True, constrained_layout=True, figsize=(5, 3))
ax2.semilogx(t, r2)
# ax2.plot(t,np.exp(-t))
ax2.set_xlim(10 ** (-2), 20)
ax2.set_ylim(1e-3, 10)
ax2.set_xlabel(r"$x$")
ax2.set_ylabel(r"$x^z e^{-x}$")
ax2.grid(1, "both")
labels =[f"$z={zi: 3.1f}$" for zi in np.squeeze(z2)]
ax2.legend(labels, ncol=2, loc="upper left", fontsize="small")
fig2.savefig(f"{img_path}/integrands_exp.pgf")
# plt.show()
