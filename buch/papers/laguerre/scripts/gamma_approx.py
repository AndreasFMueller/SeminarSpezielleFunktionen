from pathlib import Path

import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
import scipy.special

EPSILON = 1e-7
root = str(Path(__file__).parent)
img_path = f"{root}/../images"
fontsize = "medium"


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


def find_optimal_shift(z, n):
    mhat = 1.34093 * n + 0.854093
    steps = int(np.floor(mhat - np.real(z)))
    return steps


def get_shifting_factor(z, steps):
    factor = 1.0
    if steps > 0:
        factor = 1 / pochhammer(z, steps)
    elif steps < 0:
        factor = pochhammer(z + steps, -steps)
    return factor


def laguerre_gamma_shifted(z, x=None, w=None, n=8, target=11):
    x, w = _prep_zeros_and_weights(x, w, n)
    n = len(x)

    z += 0j
    steps = int(np.floor(target - np.real(z)))
    z_shifted = z + steps
    correction_factor = get_shifting_factor(z, steps)

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
