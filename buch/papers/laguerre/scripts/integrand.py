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
z = np.arange(-5, 5)[None] + 0.5


r = t ** z

fig, ax = plt.subplots(num=1, clear=True, constrained_layout=True, figsize=(6, 4))
ax.semilogx(t, r)
ax.set_xlim(*(10.**xlims))
ax.set_ylim(1e-3, 40)
ax.set_xlabel(r"$t$")
ax.set_ylabel(r"$t^z$")
ax.grid(1, "both")
labels = [f"$z={zi:.1f}$" for zi in np.squeeze(z)]
ax.legend(labels, ncol=2, loc="upper left")
fig.savefig(f"{img_path}/integrands.pdf")
# plt.show()
