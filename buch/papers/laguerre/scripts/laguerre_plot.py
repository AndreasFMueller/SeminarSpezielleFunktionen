#!/usr/bin/env python3
# -*- coding:utf-8 -*-
"""Some plots for Laguerre Polynomials."""

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import scipy.special as ss

N = 1000
t = np.linspace(0, 12.5, N)[:, None]
root = str(Path(__file__).parent)

fig, ax = plt.subplots(num=1, clear=True, constrained_layout=True, figsize=(6, 4))
for n in np.arange(0, 10):
    k = np.arange(0, n + 1)[None]
    L = np.sum((-1) ** k * ss.binom(n, k) / ss.factorial(k) * t ** k, -1)
    ax.plot(t, L, label=f"n={n}")
ax.set_xticks(np.arange(1, t[-1]))
ax.set_xlim(t[0], t[-1] + 0.1*(t[1] - t[0]))
ax.set_ylim(-20, 20)
ax.legend(ncol=2)
# set the x-spine
ax.spines['left'].set_position('zero')
ax.spines['right'].set_visible(False)
ax.spines['bottom'].set_position('zero')
ax.spines['top'].set_visible(False)
ax.xaxis.set_ticks_position('bottom')
ax.yaxis.set_ticks_position('left')

# make arrows
# ax.plot((1), (0), ls="", marker=">", ms=10, color="k",
#         transform=ax.get_yaxis_transform(), clip_on=False)
# ax.plot((0), (1), ls="", marker="^", ms=10, color="k",
#         transform=ax.get_xaxis_transform(), clip_on=False)
# ax.grid(1)
fig.savefig(f'{root}/laguerre_polynomes.pdf')
# plt.show()
