from pathlib import Path

import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
import scipy.special

EPSILON = 1e-7
root = str(Path(__file__).parent)
img_path = f"{root}/../images"


def _prep_zeros_and_weights(x, w, n):
    if x is None or w is None:
        return np.polynomial.laguerre.laggauss(n)
    return x, w


def drop_imag(z):
    if abs(z.imag) <= EPSILON:
        z = z.real
    return z


def pochhammer(z, n):
    return np.prod(z + np.arange(n))


def find_shift(z, target):
    factor = 1.0
    steps = int(np.floor(target - np.real(z)))
    zs = z + steps
    if steps > 0:
        factor = 1 / pochhammer(z, steps)
    elif steps < 0:
        factor = pochhammer(zs, -steps)
    return zs, factor


def find_optimal_shift(z, n):
    mhat = 1.34093 * n + 0.854093
    steps = int(np.floor(mhat - np.real(z)))
    return steps


def get_shifting_factor(z, steps):
    if steps > 0:
        factor = 1 / pochhammer(z, steps)
    elif steps < 0:
        factor = pochhammer(z + steps, -steps)
    return factor


def laguerre_gamma_shifted(z, x=None, w=None, n=8, target=11):
    x, w = _prep_zeros_and_weights(x, w, n)
    n = len(x)

    z += 0j
    z_shifted, correction_factor = find_shift(z, target)

    res = np.sum(x ** (z_shifted - 1) * w)
    res *= correction_factor
    res = drop_imag(res)
    return res


def laguerre_gamma_opt_shifted(z, x=None, w=None, n=8):
    x, w = _prep_zeros_and_weights(x, w, n)
    n = len(x)

    z += 0j
    opt_shift = find_optimal_shift(z, n)
    correction_factor = get_shifting_factor(z, opt_shift)
    z_shifted = z + opt_shift

    res = np.sum(x ** (z_shifted - 1) * w)
    res *= correction_factor
    res = drop_imag(res)
    return res


def laguerre_gamma_simple(z, x=None, w=None, n=8):
    x, w = _prep_zeros_and_weights(x, w, n)
    z += 0j
    res = np.sum(x ** (z - 1) * w)
    res = drop_imag(res)
    return res


def laguerre_gamma_mirror(z, x=None, w=None, n=8):
    x, w = _prep_zeros_and_weights(x, w, n)
    z += 0j
    if z.real < 1e-3:
        return np.pi / (
            np.sin(np.pi * z) * laguerre_gamma_simple(1 - z, x, w)
        )  # Reflection formula
    return laguerre_gamma_simple(z, x, w)


def eval_laguerre_gamma(z, x=None, w=None, n=8, func="simple", **kwargs):
    x, w = _prep_zeros_and_weights(x, w, n)
    if func == "simple":
        f = laguerre_gamma_simple
    elif func == "mirror":
        f = laguerre_gamma_mirror
    elif func == "optimal_shifted":
        f = laguerre_gamma_opt_shifted
    else:
        f = laguerre_gamma_shifted
    return np.array([f(zi, x, w, n, **kwargs) for zi in z])


def calc_rel_error(x, y):
    return (y - x) / x


# Simple / naive
xmin = -5
xmax = 30
ns = np.arange(2, 12, 2)
ylim = np.array([-11, 6])
x = np.linspace(xmin + EPSILON, xmax - EPSILON, 400)
gamma = scipy.special.gamma(x)
fig, ax = plt.subplots(num=1, clear=True, constrained_layout=True, figsize=(5, 2.5))
for n in ns:
    gamma_lag = eval_laguerre_gamma(x, n=n)
    rel_err = calc_rel_error(gamma, gamma_lag)
    ax.semilogy(x, np.abs(rel_err), label=f"$n={n}$")
ax.set_xlim(x[0], x[-1])
ax.set_ylim(*(10.0 ** ylim))
ax.set_xticks(np.arange(xmin, xmax + EPSILON, 5))
ax.set_xticks(np.arange(xmin, xmax), minor=True)
ax.set_yticks(10.0 ** np.arange(*ylim, 2))
ax.set_yticks(10.0 ** np.arange(*ylim, 2))
ax.set_xlabel(r"$z$")
ax.set_ylabel("Relativer Fehler")
ax.legend(ncol=3, fontsize="small")
ax.grid(1, "both")
fig.savefig(f"{img_path}/rel_error_simple.pgf")


# Mirrored
xmin = -15
xmax = 15
ylim = np.array([-11, 1])
x = np.linspace(xmin + EPSILON, xmax - EPSILON, 400)
gamma = scipy.special.gamma(x)
fig2, ax2 = plt.subplots(num=2, clear=True, constrained_layout=True, figsize=(5, 2.5))
for n in ns:
    gamma_lag = eval_laguerre_gamma(x, n=n, func="mirror")
    rel_err = calc_rel_error(gamma, gamma_lag)
    ax2.semilogy(x, np.abs(rel_err), label=f"$n={n}$")
ax2.set_xlim(x[0], x[-1])
ax2.set_ylim(*(10.0 ** ylim))
ax2.set_xticks(np.arange(xmin, xmax + EPSILON, 5))
ax2.set_xticks(np.arange(xmin, xmax), minor=True)
ax2.set_yticks(10.0 ** np.arange(*ylim, 2))
# locmin = mpl.ticker.LogLocator(base=10.0,subs=0.1*np.arange(1,10),numticks=100)
# ax2.yaxis.set_minor_locator(locmin)
# ax2.yaxis.set_minor_formatter(mpl.ticker.NullFormatter())
ax2.set_xlabel(r"$z$")
ax2.set_ylabel("Relativer Fehler")
ax2.legend(ncol=1, loc="upper left", fontsize="small")
ax2.grid(1, "both")
fig2.savefig(f"{img_path}/rel_error_mirror.pgf")


# Move to target
bests = []
N = 200
step = 1 / (N - 1)
a = 11 / 8
b = 1 / 2
x = np.linspace(step, 1 - step, N + 1)
gamma = scipy.special.gamma(x)[:, None]
ns = np.arange(2, 13)
for n in ns:
    zeros, weights = np.polynomial.laguerre.laggauss(n)
    est = np.ceil(b + a * n)
    targets = np.arange(max(est - 2, 0), est + 3)
    gamma_lag = np.stack(
        [
            eval_laguerre_gamma(x, target=target, x=zeros, w=weights, func="shifted")
            for target in targets
        ],
        -1,
    )
    rel_error = np.abs(calc_rel_error(gamma, gamma_lag))
    best = np.argmin(rel_error, -1) + targets[0]
    bests.append(best)
bests = np.stack(bests, 0)

fig3, ax3 = plt.subplots(num=3, clear=True, constrained_layout=True, figsize=(5, 3))
v = ax3.imshow(bests, cmap="inferno", aspect="auto", interpolation="nearest")
plt.colorbar(v, ax=ax3, label=r"$m$")
ticks = np.arange(0, N + 1, N // 5)
ax3.set_xlim(0, 1)
ax3.set_xticks(ticks)
ax3.set_xticklabels([f"{v:.2f}" for v in ticks / N])
ax3.set_xticks(np.arange(0, N + 1, N // 20), minor=True)
ax3.set_yticks(np.arange(len(ns)))
ax3.set_yticklabels(ns)
ax3.set_xlabel(r"$z$")
ax3.set_ylabel(r"$n$")
fig3.savefig(f"{img_path}/targets.pdf")

targets = np.mean(bests, -1)
intercept, bias = np.polyfit(ns, targets, 1)
fig4, axs4 = plt.subplots(
    2, num=4, sharex=True, clear=True, constrained_layout=True, figsize=(5, 4)
)
xl = np.array([ns[0] - 0.5, ns[-1] + 0.5])
axs4[0].plot(xl, intercept * xl + bias, label=r"$\hat{m}$")
axs4[0].plot(ns, targets, "x", label=r"$\overline{m}$")
axs4[1].plot(ns, ((intercept * ns + bias) - targets), "-x", label=r"$\hat{m} - \overline{m}$")
axs4[0].set_xlim(*xl)
# axs4[0].set_title("Schätzung von Mittelwert")
# axs4[1].set_title("Fehler")
axs4[-1].set_xlabel(r"$n$")
for ax in axs4:
    ax.grid(1)
    ax.legend()
fig4.savefig(f"{img_path}/estimate.pgf")

print(f"Intercept={intercept:.6g}, Bias={bias:.6g}")
predicts = np.ceil(intercept * ns[:, None] + bias - x)
print(f"Error: {int(np.sum(np.abs(bests-predicts)))}")

# Comparison relative error between methods
N = 200
step = 1 / (N - 1)
x = np.linspace(step, 1 - step, N + 1)
gamma = scipy.special.gamma(x)[:, None]
n = 8
targets = np.arange(10, 14)
gamma = scipy.special.gamma(x)
fig5, ax5 = plt.subplots(num=5, clear=True, constrained_layout=True)
for target in targets:
    gamma_lag = eval_laguerre_gamma(x, target=target, n=n, func="shifted")
    rel_error = np.abs(calc_rel_error(gamma, gamma_lag))
    ax5.semilogy(x, rel_error, label=f"$m={target}$", linewidth=3)
gamma_lgo = eval_laguerre_gamma(x, n=n, func="optimal_shifted")
rel_error = np.abs(calc_rel_error(gamma, gamma_lgo))
ax5.semilogy(x, rel_error, "c", linestyle="dotted", label="$m^*$", linewidth=3)
ax5.set_xlim(x[0], x[-1])
ax5.set_ylim(5e-9, 5e-8)
ax5.set_xlabel(r"$z$")
ax5.grid(1, "both")
ax5.legend()
fig5.savefig(f"{img_path}/rel_error_shifted.pgf")

N = 200
x = np.linspace(-5+ EPSILON, 5-EPSILON, N)
gamma = scipy.special.gamma(x)[:, None]
n = 8
gamma = scipy.special.gamma(x)
fig6, ax6 = plt.subplots(num=6, clear=True, constrained_layout=True)
gamma_lgo = eval_laguerre_gamma(x, n=n, func="optimal_shifted")
rel_error = np.abs(calc_rel_error(gamma, gamma_lgo))
ax6.semilogy(x, rel_error, label="$m^*$", linewidth=3)
ax6.set_xlim(x[0], x[-1])
ax6.set_ylim(5e-9, 5e-8)
ax6.set_xlabel(r"$z$")
ax6.grid(1, "both")
ax6.legend()
fig6.savefig(f"{img_path}/rel_error_range.pgf")

N = 2001
x = np.linspace(-5, 5, N)
gamma = scipy.special.gamma(x)
fig7, ax7 = plt.subplots(num=7, clear=True, constrained_layout=True)
ax7.plot(x, gamma)
ax7.set_xlim(x[0], x[-1])
ax7.set_ylim(-7.5, 25)
ax7.grid(1, "both")
fig7.savefig(f"{img_path}/gamma.pgf")

# plt.show()
