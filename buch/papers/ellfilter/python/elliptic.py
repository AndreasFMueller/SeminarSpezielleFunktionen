
# %%

import scipy.special
import scipyx as spx
import numpy as np
import matplotlib.pyplot as plt
import matplotlib
from matplotlib.patches import Rectangle

matplotlib.rcParams.update({
    "pgf.texsystem": "pdflatex",
    'font.family': 'serif',
    'font.size': 9,
    'text.usetex': True,
    'pgf.rcfonts': False,
})

def last_color():
    plt.gca().lines[-1].get_color()

# %% Buttwerworth filter F_N plot

w = np.linspace(0,1.5, 100)
plt.figure(figsize=(4,2.5))

for N in range(1,5):
    F_N = w**N
    plt.plot(w, F_N**2, label=f"$N={N}$")
plt.gca().add_patch(Rectangle(
    (0, 0),
    1, 1,
    fc ='green',
    alpha=0.2,
    lw = 10,
))
plt.gca().add_patch(Rectangle(
    (1, 1),
    0.5, 1,
    fc ='green',
    alpha=0.2,
    lw = 10,
))
plt.xlim([0,1.5])
plt.ylim([0,2])
plt.grid()
plt.xlabel("$w$")
plt.ylabel("$F^2_N(w)$")
plt.legend()
plt.savefig("F_N_butterworth.pdf")
plt.show()

# %% Cheychev filter F_N plot

w = np.linspace(0,1.5, 100)

plt.figure(figsize=(4,2.5))
for N in range(1,5):
    # F_N = np.cos(N * np.arccos(w))
    F_N = scipy.special.eval_chebyt(N, w)
    plt.plot(w, F_N**2, label=f"$N={N}$")
plt.gca().add_patch(Rectangle(
    (0, 0),
    1, 1,
    fc ='green',
    alpha=0.2,
    lw = 10,
))
plt.gca().add_patch(Rectangle(
    (1, 1),
    0.5, 1,
    fc ='green',
    alpha=0.2,
    lw = 10,
))
plt.xlim([0,1.5])
plt.ylim([0,2])
plt.grid()
plt.xlabel("$w$")
plt.ylabel("$F^2_N(w)$")
plt.legend()
plt.savefig("F_N_chebychev.pdf")
plt.show()

# %% define elliptic functions

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

# https://mathworld.wolfram.com/JacobiEllipticFunctions.html eq 3-8

def sn_inv(z, k):
    m = k**2
    return scipy.special.ellipkinc(np.arcsin(z), m)

def cn_inv(z, k):
    m = k**2
    return scipy.special.ellipkinc(np.arccos(z), m)

def dn_inv(z, k):
    m = k**2
    x = np.sqrt((1-z**2) / k**2)
    return scipy.special.ellipkinc(np.arcsin(x), m)

def cd_inv(z, k):
    m = k**2
    x = np.sqrt(((m - 1) * z**2) / (m*z**2 - 1))
    return scipy.special.ellipkinc(np.arccos(x), m)


k = 0.8
z = 0.5

assert np.allclose(sn_inv(sn(z ,k), k), z)
assert np.allclose(cn_inv(cn(z ,k), k), z)
assert np.allclose(dn_inv(dn(z ,k), k), z)
assert np.allclose(cd_inv(cd(z ,k), k), z)

# %% plot arcsin

def lattice(a1, b1, c1, a2, b2, c2):
    r1 = np.logspace(a1, b1, c1)
    x1 = np.concatenate((-np.flip(r1), [0], r1), axis=0)
    x1 = x1.astype(np.complex128)
    r2 = np.logspace(a2, b2, c2)
    x2 = np.concatenate((-np.flip(r2), [0], r2), axis=0)
    x2 = x2.astype(np.complex128)
    x = (x1[:, None] + (x2[None, :] * 1j))
    return x

plt.figure(figsize=(12,12))
y = np.arcsin(lattice(-1,6,1000, -1,5,10))
plt.plot(np.real(y), np.imag(y), "-", color="red", lw=0.5)
y = np.arcsin(lattice(-1,6,10, -1,5,100)).T
plt.plot(np.real(y), np.imag(y), "-", color="red", lw=0.5)
y = np.arcsin(lattice(-1,6,10, -1,5,10))
plt.plot(np.real(y), np.imag(y), ".", color="red", lw=0.5)
plt.show()

# %% plot cd^-1 TODO complex cd^-1 missing


r = np.logspace(-1,8, 50)



x = np.concatenate((-np.flip(r), [0], r), axis=0)
y = cd_inv(x, 0.99)

plt.figure(figsize=(12,12))
plt.plot(np.real(y), np.imag(y), "-")
plt.show()

# %%plot cd
plt.figure(figsize=(10,6))
z = np.linspace(-4,4, 500)
for k in [0, 0.9, 0.99, 0.999, 0.99999]:
    w = cd(z*ell_int(k), k)
    plt.plot(z, w, label=f"$k={k}$")
plt.grid()
plt.legend()
# plt.xlim([-4,4])
plt.xlabel("$u$")
plt.ylabel("$cd(uK, k)$")
plt.show()

# %% Test ????

N = 5
k = 0.9
k1 = k**N

assert np.allclose(k**(-N), k1**(-1))

K = ell_int(k)
Kp = ell_int(np.sqrt(1-k**2))

K1 = ell_int(k1)
Kp1 = ell_int(np.sqrt(1-k1**2))

print(Kp * (K1 / K) * N, Kp1)


# %%


k = 0.9
k_prim = np.sqrt(1 - k**2)
K = ell_int(k)
Kp = ell_int(k_prim)

print(K, Kp)

zs = [
    0 + (K + 0j) * np.linspace(0,1,25),
    K +  (Kp*1j) * np.linspace(0,1,25),
    (K + Kp*1j) + (-K) * np.linspace(0,1,25),
]


for z in zs:
    plt.plot(np.real(z),  np.imag(z))
plt.show()



for z in zs:
    w = cd(z, k)
    plt.plot(np.real(w),  np.imag(w))
plt.show()





# %%

for i in range(10):
    x = np.linspace(i*1,i*1+1,10, dtype=np.complex64)
    w = np.arccos(x)

    x2 = np.cos(w)
    x4 = np.cos(w+ 2*np.pi)
    x3 = np.cos(np.conj(w))

    assert np.allclose(x2, x4, rtol=0.001, atol=1e-5)

    assert np.allclose(x2, x3)
    assert np.allclose(x2, x, rtol=0.001, atol=1e-5)

    plt.plot(np.real(w), np.imag(w), ".-")

for i in range(10):
    x = -np.linspace(i*1,i*1+1,100, dtype=np.complex64)
    w = np.arccos(x)
    plt.plot(np.real(w), np.imag(w), ".-")

plt.grid()
plt.show()




# %%

plt.plot(omega, np.abs(G))
plt.show()


def cd_inv(u, m):
    return K(1/2) - F(np.arcsin())

def K(m):
    return scipy.special.ellipk(m)

def L(n, xi):
    return 1 #TODO

def R(n, xi, x):
    cn(n*K(1/L(n, xi))/K(1/xi) * cd_inv(x, 1/xi, 1/L(n, xi)))

epsilon = 0.1
n = 3
omega = np.linspace(0, np.pi, 1000)
omega_0 = 1
xi = 1.1

G = 1 / np.sqrt(1 + epsilon**2 * R(n, xi, omega/omega_0)**2)


plt.plot(omega, np.abs(G))
plt.show()



# %% Chebychef

epsilon = 0.5
omega = np.linspace(0, np.pi, 1000)
omega_0 = 1
n = 4

def chebychef_poly(n, x):
    x = x.astype(np.complex64)
    y = np.cos(n* np.arccos(x))
    return np.real(y)

F_omega = chebychef_poly

for n in (1,2,3,4):
    plt.plot(omega, F_omega(n, omega/omega_0)**2)
plt.ylim([0,5])
plt.xlim([0,1.5])
plt.grid()
plt.show()

for n in (1,2,3,4):
    G = 1 / np.sqrt(1 + epsilon**2 * F_omega(n, omega/omega_0)**2)
    plt.plot(omega, np.abs(G))
plt.grid()
plt.show()
