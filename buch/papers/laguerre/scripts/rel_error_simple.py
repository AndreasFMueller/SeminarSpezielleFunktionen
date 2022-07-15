if __name__ == "__main__":
    import matplotlib as mpl
    import matplotlib.pyplot as plt
    import numpy as np
    import scipy.special

    import gamma_approx as ga

    # mpl.rc("text", usetex=True)
    mpl.rcParams.update(
        {
            "mathtext.fontset": "stix",
            "font.family": "serif",
            "font.serif": "TeX Gyre Termes",
        }
    )
    # mpl.rcParams.update({"font.family": "serif", "font.serif": "TeX Gyre Termes"})

    # Simple / naive
    xmin = -5
    xmax = 30
    ns = np.arange(2, 12, 2)
    ylim = np.array([-11, 6])
    x = np.linspace(xmin + ga.EPSILON, xmax - ga.EPSILON, 400)
    gamma = scipy.special.gamma(x)
    fig, ax = plt.subplots(num=1, clear=True, constrained_layout=True, figsize=(5, 2.5))
    for n in ns:
        gamma_lag = ga.eval_laguerre_gamma(x, n=n)
        rel_err = ga.calc_rel_error(gamma, gamma_lag)
        ax.semilogy(x, np.abs(rel_err), label=f"$n={n}$")
    ax.set_xlim(x[0], x[-1])
    ax.set_ylim(*(10.0 ** ylim))
    ax.set_xticks(np.arange(xmin, xmax + ga.EPSILON, 5))
    ax.set_xticks(np.arange(xmin, xmax), minor=True)
    ax.set_yticks(10.0 ** np.arange(*ylim, 2))
    ax.set_xlabel(r"$z$")
    # ax.set_ylabel("Relativer Fehler")
    ax.legend(ncol=3, fontsize=ga.fontsize)
    ax.grid(1, "both")
    # fig.savefig(f"{ga.img_path}/rel_error_simple.pgf")
    fig.savefig(f"{ga.img_path}/rel_error_simple.pdf")
