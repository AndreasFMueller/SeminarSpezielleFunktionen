#!/usr/bin/env python3
# -*- coding:utf-8 -*-
"""Plot for integrand of gamma function with shifting terms."""

if __name__ == "__main__":
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

    z = np.array([-1, -0.5, 0.0, 0.5, 1, 2, 3, 4, 4.5])
    e = np.exp(-t)
    r = t ** z * e

    fig, ax = plt.subplots(num=2, clear=True, constrained_layout=True, figsize=(4, 2.4))
    ax.semilogx(t, r)
    # ax.plot(t,np.exp(-t))
    ax.set_xlim(10 ** (-2), 20)
    ax.set_ylim(1e-3, 10)
    ax.set_xlabel(r"$x$")
    # ax.set_ylabel(r"$x^z e^{-x}$")
    ax.grid(1, "both")
    labels = [f"$z={zi: 3.1f}$" for zi in np.squeeze(z)]
    ax.legend(labels, ncol=2, loc="upper left", fontsize="small")
    fig.savefig(f"{img_path}/integrand_exp.pgf")
    # plt.show()
