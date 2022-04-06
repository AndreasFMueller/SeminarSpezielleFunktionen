#!/usr/bin/env python3
# -*- coding:utf-8 -*-
"""Use Gauss-Laguerre quadrature to calculate gamma function."""
# import sympy
from cmath import exp, pi, sin, sqrt

import matplotlib.pyplot as plt
import numpy as np
import scipy.special as ss

p = [
    676.5203681218851,
    -1259.1392167224028,
    771.32342877765313,
    -176.61502916214059,
    12.507343278686905,
    -0.13857109526572012,
    9.9843695780195716e-6,
    1.5056327351493116e-7,
]

EPSILON = 1e-07


def drop_imag(z):
    if abs(z.imag) <= EPSILON:
        z = z.real
    return z


def gamma(z):
    z = complex(z)
    if z.real < 0.5:
        y = pi / (sin(pi * z) * gamma(1 - z))  # Reflection formula
    else:
        z -= 1
        x = 0.99999999999980993
        for (i, pval) in enumerate(p):
            x += pval / (z + i + 1)
        t = z + len(p) - 0.5
        y = sqrt(2 * pi) * t ** (z + 0.5) * exp(-t) * x
    return drop_imag(y)


zeros = np.array(
    [
        3.22547689619392312e-1,
        1.74576110115834658e0,
        4.53662029692112798e0,
        9.39507091230113313e0,
    ],
    np.longdouble,
)
weights = np.array(
    [
        6.03154104341633602e-1,
        3.57418692437799687e-1,
        3.88879085150053843e-2,
        5.39294705561327450e-4,
    ],
    np.longdouble,
)

zeros = np.array(
    [
        1.70279632305101000e-1,
        9.03701776799379912e-1,
        2.25108662986613069e0,
        4.26670017028765879e0,
        7.04590540239346570e0,
        1.07585160101809952e1,
        1.57406786412780046e1,
        2.28631317368892641e1,
    ],
    np.longdouble,
)

weights = np.array(
    [
        3.69188589341637530e-1,
        4.18786780814342956e-1,
        1.75794986637171806e-1,
        3.33434922612156515e-2,
        2.79453623522567252e-3,
        9.07650877335821310e-5,
        8.48574671627253154e-7,
        1.04800117487151038e-9,
    ],
    np.longdouble,
)


def calc_gamma(z, n, x, w):
    res = 0.0
    z = complex(z)
    for xi, wi in zip(x, w):
        res += xi ** (z + n - 1) * wi
    for i in range(int(n)):
        res /= z + i
    res = drop_imag(res)
    return res

small = 1e-3
Z = np.linspace(small, 1-small, 101)

# Z = [-3/2, -1/2, 1/2, 3/2]
# target =
# targets = np.array([gamma(z) for z in Z])
targets1 = ss.gamma(Z)
targets2 =  np.array([gamma(z) for z in Z])
approxs = np.array([calc_gamma(z, 11, zeros, weights) for z in Z])
rel_error1 = np.abs(targets1 - approxs) / targets1
rel_error2 = np.abs(targets2 - approxs) / targets2

_, axs = plt.subplots(2, num=1, clear=True, constrained_layout=True)
axs[0].plot(Z, rel_error1)
axs[1].semilogy(Z, rel_error1)
axs[0].plot(Z, rel_error2)
axs[1].semilogy(Z, rel_error2)
axs[1].semilogy(Z, np.abs(targets1-targets2)/targets1)
plt.show()
# values = np.array([calc_gamma])
# _ = [
#     print(
#         n,
#         [
#             float(
#                 f"{np.abs((calc_gamma(z, n, zeros, weights) - gamma(z)) / gamma(z)):.3g}"
#             )
#             for z in Z
#         ],
#     )
#     for n in range(21)
# ]


# target = ss.gamma(z)
# target = np.sqrt(np.pi)

# _, ax = plt.subplots(num=1, clear=True, constrained_layout=True)
# for i, degree in enumerate(degrees):
#     samples_points, weights = np.polynomial.laguerre.laggauss(degree)
#     values = np.sum(
#         samples_points[:, None] ** (z + shifts[None] - 1) * weights[:, None], 0
#     ) / ss.poch(z, shifts)
#     # print(np.abs(target - values))
#     print(values)
#     ax.plot(shifts, values, label=f"N={degree}")
# ax.legend()
# plt.show()


# def count_equal_digits(x, y):
#     for i in range(1, 13):
#         try:
#             np.testing.assert_almost_equal(x, y, i)
#         except AssertionError:
#             break
#     return i


# Z = np.linspace(1.0, 11.0, 11)
# # degrees = [2, 4, 8, 16, 32, 64, 100]
# d = 100
# X = np.zeros(len(Z))
# for i, z in enumerate(Z):
#     samples_points, weights = np.polynomial.laguerre.laggauss(d)
#     X[i] = np.sum(samples_points ** (z - 1) * weights)
#     # X[i] = np.sum(np.sin(z * samples_points) * weights)
# Y = ss.gamma(Z)
# # Y = Z / (Z ** 2 + 1)
# ed = [count_equal_digits(x, y) for x, y in zip(X, Y)]
# for x,y in zip(X,Y):
#     print(x,y)

# _, ax = plt.subplots(num=1, clear=True, constrained_layout=True)
# ax.plot(Z, ed)
# plt.show()
