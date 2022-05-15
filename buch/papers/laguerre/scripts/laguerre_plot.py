#!/usr/bin/env python3
# -*- coding:utf-8 -*-
"""Some plots for Laguerre Polynomials."""

import os
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import scipy.special as ss


def get_ticks(start, end, step=1):
    ticks = np.arange(start, end, step)
    return ticks[ticks != 0]


N = 1000
step = 5
t = np.linspace(-1.05, 10.5, N)[:, None]
root = str(Path(__file__).parent)
img_path = f"{root}/../images"
os.makedirs(img_path, exist_ok=True)


# fig = plt.figure(num=1, clear=True, tight_layout=True, figsize=(5.5, 3.7))
# ax = fig.add_subplot(axes_class=AxesZero)
fig, ax = plt.subplots(num=1, clear=True, constrained_layout=True, figsize=(6, 4))
for n in np.arange(0, 8):
    k = np.arange(0, n + 1)[None]
    L = np.sum((-1) ** k * ss.binom(n, k) / ss.factorial(k) * t ** k, -1)
    ax.plot(t, L, label=f"n={n}")

ax.set_xticks(get_ticks(int(t[0]), t[-1]), minor=True)
ax.set_xticks(get_ticks(0, t[-1], step))
ax.set_xlim(t[0], t[-1] + 0.1 * (t[1] - t[0]))
ax.set_xlabel(r"$x$", x=1.0, labelpad=-10, rotation=0, fontsize="large")

ylim = 13
ax.set_yticks(np.arange(-ylim, ylim), minor=True)
ax.set_yticks(np.arange(-step * (ylim // step), ylim, step))
ax.set_ylim(-ylim, ylim)
ax.set_ylabel(r"$y$", y=0.95, labelpad=-18, rotation=0, fontsize="large")

ax.legend(ncol=2, loc=(0.125, 0.01), fontsize="large")

# set the x-spine
ax.spines[["left", "bottom"]].set_position("zero")
ax.spines[["right", "top"]].set_visible(False)
ax.xaxis.set_ticks_position("bottom")
hlx = 0.4
dx = t[-1, 0] - t[0, 0]
dy = 2 * ylim
hly = dy / dx * hlx
dps = fig.dpi_scale_trans.inverted()
bbox = ax.get_window_extent().transformed(dps)
width, height = bbox.width, bbox.height

# manual arrowhead width and length
hw = 1.0 / 60.0 * dy
hl = 1.0 / 30.0 * dx
lw = 0.5  # axis line width
ohg = 0.0  # arrow overhang

# compute matching arrowhead length and width
yhw = hw / dy * dx * height / width
yhl = hl / dx * dy * width / height

# draw x and y axis
ax.arrow(
    t[-1, 0] - hl,
    0,
    hl,
    0.0,
    fc="k",
    ec="k",
    lw=lw,
    head_width=hw,
    head_length=hl,
    overhang=ohg,
    length_includes_head=True,
    clip_on=False,
)

ax.arrow(
    0,
    ylim - yhl,
    0.0,
    yhl,
    fc="k",
    ec="k",
    lw=lw,
    head_width=yhw,
    head_length=yhl,
    overhang=ohg,
    length_includes_head=True,
    clip_on=False,
)

fig.savefig(f"{img_path}/laguerre_polynomes.pdf")
