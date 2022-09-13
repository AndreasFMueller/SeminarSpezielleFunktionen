import numpy as np
import pandas as pd
import scipy.special

import seaborn as sns
import seaborn_image as isns
import matplotlib.pyplot as plt

import toolz

# Basis functions for 2D Fourier

@np.vectorize
@toolz.curry
def b(m, n, mu, nu):
    return np.exp(2j * np.pi * (m * mu + n * nu))

N = 100
H = 4

basis = []
for m in range(H):
    for n in range(H + 1):
        mu = np.linspace(0, 1, N)
        nu = np.linspace(0, 1, N)
        muv, nuv = np.meshgrid(mu, nu)

        bs = np.real(b(m, n, muv, nuv))
        basis.append(bs)

g = isns.ImageGrid(basis, col_wrap=(H + 1), cbar=False)
g.fig.savefig("flat-basis-functions.pdf")

plt.tight_layout()
plt.show()

# Legendre Polynomials

N = 100

sns.set_theme("talk", "darkgrid", font_scale=.75)
fig, axes = plt.subplots(3, 4, figsize=(12, 8))

x = np.linspace(-1, 1, N)
for n in range(np.prod(axes.shape)):
    p = scipy.special.lpmv(0, n, x)
    # axes.ravel()[n].plot(x, p)
    sns.lineplot(ax=axes.ravel()[n], x=x, y=p)

plt.tight_layout()
fig.savefig("legendre-polynomials.pdf")
plt.show()

# Associated Legendre Polynomials

N = 100

sns.set_theme("talk", "darkgrid", font_scale=.75)
fig, axes = plt.subplots(2, 3, figsize=(12, 8))

x = np.linspace(-1, 1, N)

for m in range(3 * 2):
    for n in range(5):
        p = scipy.special.lpmv(m, m + n, x)
        sns.lineplot(ax=axes.ravel()[m], x=x, y=p)
        # sns.lineplot(x=x, y=p)

plt.tight_layout()
fig.savefig("associated-legendre-polynomials.pdf")
plt.show()
