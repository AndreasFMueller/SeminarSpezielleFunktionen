if __name__ == "__main__":
    import matplotlib as mpl
    import matplotlib.pyplot as plt
    import numpy as np
    import scipy.special

    import gamma_approx as ga

    mpl.rcParams.update(
        {
            "mathtext.fontset": "stix",
            "font.family": "serif",
            "font.serif": "TeX Gyre Termes",
        }
    )
    
    xmax = 4
    vals = np.linspace(-xmax + ga.EPSILON, xmax, 100)
    x, y = np.meshgrid(vals, vals)
    mesh = x + 1j * y
    input = mesh.flatten()

    lanczos = scipy.special.gamma(mesh)
    lag = ga.eval_laguerre_gamma(input, n=8, func="optimal_shifted").reshape(mesh.shape)
    rel_error = np.abs(ga.calc_rel_error(lanczos, lag))

    fig, ax = plt.subplots(clear=True, constrained_layout=True, figsize=(4, 2.4))
    _c = ax.pcolormesh(
        x, y, rel_error, shading="gouraud", cmap="inferno", norm=mpl.colors.LogNorm()
    )
    cbr = fig.colorbar(_c, ax=ax)
    cbr.minorticks_off()
    # ax.set_title("Relative Error")
    ax.set_xlabel("Re($z$)")
    ax.set_ylabel("Im($z$)")
    minor_ticks = np.arange(-xmax, xmax + ga.EPSILON)
    ticks = np.arange(-xmax, xmax + ga.EPSILON, 2)
    ax.set_xticks(ticks)
    ax.set_xticks(minor_ticks, minor=True)
    ax.set_yticks(ticks)
    ax.set_yticks(minor_ticks, minor=True)
    fig.savefig(f"{ga.img_path}/rel_error_complex.pdf")
    # plt.show()
