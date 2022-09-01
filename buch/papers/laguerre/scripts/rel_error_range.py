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
    N = 1201
    xmax = 6
    xmin = -xmax
    ns = np.arange(2, 12, 2)
    ylim = np.array([-11, -1.2])

    x = np.linspace(xmin + ga.EPSILON, xmax - ga.EPSILON, N)
    gamma = scipy.special.gamma(x)
    fig, ax = plt.subplots(num=1, clear=True, constrained_layout=True, figsize=(5, 2))
    for n in ns:
        gamma_lag = ga.eval_laguerre_gamma(x, n=n, func="optimal_shifted")
        rel_err = ga.calc_rel_error(gamma, gamma_lag)
        ax.semilogy(x, np.abs(rel_err), label=f"$n={n}$")
    ax.set_xlim(x[0], x[-1])
    ax.set_ylim(*(10.0 ** ylim))
    ax.set_xticks(np.arange(xmin, xmax + ga.EPSILON, 2))
    ax.set_xticks(np.arange(xmin, xmax + ga.EPSILON), minor=True)
    ax.set_yticks(10.0 ** np.arange(*ylim, 2))
    ax.set_yticks(10.0 ** np.arange(*ylim, 1), "", minor=True)
    ax.set_xlabel(r"$z$")
    # ax.set_ylabel("Relativer Fehler")
    ax.legend(ncol=1, loc="upper left", fontsize=ga.fontsize)
    ax.grid(1, "both")
    # fig.savefig(f"{ga.img_path}/rel_error_range.pgf")
    fig.savefig(f"{ga.img_path}/rel_error_range.pdf")
    # plt.show()
