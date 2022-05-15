# %%

import matplotlib.pyplot as plt
import scipy.signal
import numpy as np


order = 5
passband_ripple_db = 1
omega_c = 1000

a, b = scipy.signal.cheby1(
    order,
    passband_ripple_db,
    omega_c,
    btype='low',
    analog=True,
    output='ba',
    fs=None,
)

w, mag, phase = scipy.signal.bode((a, b), w=np.linspace(0,2000,256))
f, axs = plt.subplots(2,1, sharex=True)
axs[0].plot(w, 10**(mag/20))
axs[0].set_ylabel("$|H(\omega)| /$ db")
axs[0].grid(True, "both")
axs[1].plot(w, phase)
axs[1].set_ylabel(r"$arg H (\omega) / $ deg")
axs[1].grid(True, "both")
axs[1].set_xlim([0, 2000])
axs[1].set_xlabel("$\omega$")
plt.show()


# %% Cheychev filter F_N plot

w = np.linspace(-1.1,1.1, 1000)
plt.figure(figsize=(5.5,2))
for N in [3,6,11]:
    # F_N = np.cos(N * np.arccos(w))
    F_N = scipy.special.eval_chebyt(N, w)
    plt.plot(w, F_N, label=f"$N={N}$")
plt.xlim([-1.2,1.2])
plt.ylim([-2,2])
plt.grid()
plt.xlabel("$w$")
plt.ylabel("$C_N(w)$")
plt.legend()
plt.savefig("F_N_chebychev2.pdf")
plt.show()

# %% Build Chebychev polynomials

N = 11

zeros = (np.arange(N)+0.5) * np.pi
zeros = np.cos(zeros/N)

x = np.linspace(-1.2,1.2,1000)
y = np.prod(x[:, None] - zeros[None, :], axis=-1)*2**(N-1)

plt.plot(x, y)
plt.ylim([-1,1])
plt.grid()
plt.show()
