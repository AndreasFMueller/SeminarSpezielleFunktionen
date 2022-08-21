# %%

import matplotlib.pyplot as plt
import scipy.signal
import numpy as np
import matplotlib
from matplotlib.patches import Rectangle
import scipy.special
import scipyx as spx

# import plot_params

def last_color():
    return plt.gca().lines[-1].get_color()

# define elliptic functions

def ell_int(k):
    """ Calculate K(k) """
    m = k**2
    return scipy.special.ellipk(m)

def sn(z, k):
    return spx.ellipj(z, k**2)[0]

def cn(z, k):
    return spx.ellipj(z, k**2)[1]

def dn(z, k):
    return spx.ellipj(z, k**2)[2]

def cd(z, k):
    sn, cn, dn, ph = spx.ellipj(z, k**2)
    return cn / dn

N = 6
L = (N//2) * 2
r = N - L

k = 0.9143

i = np.arange(1, L+1)
ui = (2*i - 1) / N
k1 = k**N * np.prod(sn(ui*ell_int(k), k)**4)
k1 = 0.0165
k1 = 0.0058


kp = np.sqrt(1-k**2)
k1p = np.sqrt(1-k1**2)

K = ell_int(k)
Kp = ell_int(kp)
K1 = ell_int(k1)
K1p = ell_int(k1p)

# assert np.allclose(Kp*K1*N/K, K1p, rtol=0.001)

zeros = K/N * (np.arange(N)*2 + 1)
poles = zeros + (1j * Kp)
# if len(poles) % 2 == 0:
#     poles = np.delete(poles, len(poles)//2)


plt.plot(np.real(zeros), np.imag(zeros), "o")
plt.plot(np.real(poles), np.imag(poles), "x")
# plt.plot([0,K1], [0,K1p])
# plt.plot([0,K], [0,Kp])
plt.show()

zeros = cd(zeros, k)
poles = cd(poles, k)

plt.plot(np.real(zeros), np.imag(zeros), "o")
plt.plot(np.real(poles), np.imag(poles), "x")
plt.ylim([-0.1,0.1])
plt.xlim([-2.5,2.5])
plt.show()

w = np.linspace(0,2, 2000)

def make_RN(w):
    y = np.prod(w[:, None] - zeros[None], axis=-1) / np.prod(w[:, None] - poles[None], axis=-1)
    y /= np.prod(1 - zeros) / np.prod(1 - poles)
    return y


RN = make_RN(w)

plt.semilogy(w, np.abs(RN))
plt.ylim([0.1,1000])

plt.plot(w, np.ones_like(w) / k1)

plt.show()

H = 1 / (1 + RN**2)

plt.semilogy(w, np.abs(H))
plt.ylim([0.00001,1])
plt.show()
