#!/usr/bin/env python3
# -*- coding:utf-8 -*-
"""Plot for integrand of gamma function with shifting terms."""

if __name__ == "__main__":
    import os
    from pathlib import Path

    import matplotlib as mpl
    import matplotlib.pyplot as plt
    import numpy as np

    mpl.rcParams.update(
        {
            "mathtext.fontset": "stix",
            "font.family": "serif",
            "font.serif": "TeX Gyre Termes",
        }
    )
    
    EPSILON = 1e-12
    xlims = np.array([-3, 3])

    root = str(Path(__file__).parent)
    img_path = f"{root}/../images"
    os.makedirs(img_path, exist_ok=True)

    t = np.logspace(*xlims, 1001)[:, None]

    z = np.array([-4.5, -2, -1, -0.5, 0.0, 0.5, 1, 2, 4.5])
    r = t ** z

    fig, ax = plt.subplots(num=1, clear=True, constrained_layout=True, figsize=(4, 2.4))
    ax.semilogx(t, r)
    ax.set_xlim(*(10.0 ** xlims))
    ax.set_ylim(1e-3, 40)
    ax.set_xlabel(r"$x$")
    # ax.set_ylabel(r"$x^z$")
    ax.grid(1, "both")
    labels = [f"$z={zi: 3.1f}$" for zi in np.squeeze(z)]
    ax.legend(labels, ncol=2, loc="upper left", fontsize="small")
    fig.savefig(f"{img_path}/integrand.pdf")
