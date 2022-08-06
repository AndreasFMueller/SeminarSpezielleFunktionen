if __name__ == "__main__":
    import matplotlib as mpl
    import matplotlib.pyplot as plt
    import numpy as np

    import gamma_approx as ga
    import targets

    mpl.rcParams.update(
        {
            "mathtext.fontset": "stix",
            "font.family": "serif",
            "font.serif": "TeX Gyre Termes",
        }
    )
    
    N = 200
    ns = np.arange(1, 13)
    step = 1 / (N - 1)
    x = np.linspace(step, 1 - step, N + 1)

    bests = targets.find_best_loc(N, ns=ns)
    mean_m = np.mean(bests, -1)

    intercept, bias = np.polyfit(ns, mean_m, 1)
    fig, axs = plt.subplots(
        2, num=1, sharex=True, clear=True, constrained_layout=True, figsize=(4.5, 3.6)
    )
    xl = np.array([ns[0] - 0.5, ns[-1] + 0.5])
    axs[0].plot(xl, intercept * xl + bias, label=r"$\hat{m}$")
    axs[0].plot(ns, mean_m, "x", label=r"$\overline{m}$")
    axs[1].plot(
        ns, ((intercept * ns + bias) - mean_m), "-x", label=r"$\hat{m} - \overline{m}$"
    )
    axs[0].set_xlim(*xl)
    axs[0].set_xticks(ns)
    axs[0].set_yticks(np.arange(np.floor(mean_m[0]), np.ceil(mean_m[-1]) + 0.1, 2))
    # axs[0].set_title("Schätzung von Mittelwert")
    # axs[1].set_title("Fehler")
    axs[-1].set_xlabel(r"$n$")
    for ax in axs:
        ax.grid(1)
        ax.legend()
    # fig.savefig(f"{ga.img_path}/estimates.pgf")
    fig.savefig(f"{ga.img_path}/estimates.pdf")

    print(f"Intercept={intercept:.6g}, Bias={bias:.6g}")
    predicts = np.ceil(intercept * ns[:, None] + bias - np.real(x))
    print(f"Error: {np.mean(np.abs(bests - predicts))}")
