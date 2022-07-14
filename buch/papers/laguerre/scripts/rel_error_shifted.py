if __name__ == "__main__":
    import matplotlib.pyplot as plt
    import numpy as np
    import scipy.special

    import gamma_approx as ga

    n = 8  # order of Laguerre polynomial
    N = 200  # number of points in interval

    step = 1 / (N - 1)
    x = np.linspace(step, 1 - step, N + 1)
    targets = np.arange(10, 14)
    gamma = scipy.special.gamma(x)
    fig, ax = plt.subplots(num=1, clear=True, constrained_layout=True, figsize=(5, 2.5))
    for target in targets:
        gamma_lag = ga.eval_laguerre_gamma(x, target=target, n=n, func="shifted")
        rel_error = np.abs(ga.calc_rel_error(gamma, gamma_lag))
        ax.semilogy(x, rel_error, label=f"$m={target}$", linewidth=3)
    gamma_lgo = ga.eval_laguerre_gamma(x, n=n, func="optimal_shifted")
    rel_error = np.abs(ga.calc_rel_error(gamma, gamma_lgo))
    ax.semilogy(x, rel_error, "m", linestyle="dotted", label="$m^*$", linewidth=3)
    ax.set_xlim(x[0], x[-1])
    ax.set_ylim(5e-9, 5e-8)
    ax.set_xlabel(r"$z$")
    ax.set_xticks(np.linspace(0, 1, 6))
    ax.set_xticks(np.linspace(0, 1, 11), minor=True)
    ax.grid(1, "both")
    ax.legend(ncol=1, fontsize=ga.fontsize)
    fig.savefig(f"{ga.img_path}/rel_error_shifted.pgf")
    # plt.show()
