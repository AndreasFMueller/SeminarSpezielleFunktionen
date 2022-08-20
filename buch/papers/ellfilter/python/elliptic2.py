# %%

import enum
import matplotlib.pyplot as plt
import scipy.signal
import numpy as np
import matplotlib
from matplotlib.patches import Rectangle

import plot_params

N=5

def ellip_filter(N, mode=-1):

    order = N
    passband_ripple_db = 3
    stopband_attenuation_db = 20
    omega_c = 1

    a, b = scipy.signal.ellip(
        order,
        passband_ripple_db,
        stopband_attenuation_db,
        omega_c,
        btype='low',
        analog=True,
        output='ba',
        fs=None
    )

    if mode == 0:
        w = np.linspace(0*omega_c,omega_c, 2000)
    elif mode == 1:
        w = np.linspace(omega_c,1.00992*omega_c, 2000)
    elif mode == 2:
        w = np.linspace(1.00992*omega_c,2*omega_c, 2000)
    else:
        w = np.linspace(0*omega_c,2*omega_c, 4000)

    w, mag_db, phase = scipy.signal.bode((a, b), w=w)

    mag = 10**(mag_db/20)

    passband_ripple = 10**(-passband_ripple_db/20)
    epsilon2 = (1/passband_ripple)**2 - 1

    FN2 = ((1/mag**2) - 1)

    return w/omega_c, FN2 / epsilon2, mag, a, b


f, axs = plt.subplots(2, 1, figsize=(5,3), sharex=True)

for mode, c in enumerate(["green", "orange", "red"]):
    w, FN2, mag, a, b = ellip_filter(N, mode=mode)
    axs[0].semilogy(w, FN2, label=f"$N={N}, k=0.1$", linewidth=1, color=c)

axs[0].add_patch(Rectangle(
    (0, 0),
    1, 1,
    fc ='green',
    alpha=0.2,
    lw = 10,
))
axs[0].add_patch(Rectangle(
    (1, 1),
    0.00992, 1e2-1,
    fc ='orange',
    alpha=0.2,
    lw = 10,
))

axs[0].add_patch(Rectangle(
    (1.00992, 100),
    1, 1e6,
    fc ='red',
    alpha=0.2,
    lw = 10,
))

zeros = [0,0.87,0.995]
poles = [1.01,1.155, 2.05]

import matplotlib.transforms
axs[0].plot( # mark errors as vertical bars
    zeros,
    np.zeros_like(zeros)-0.075,
    "o",
    mfc='none',
    color='black',
    transform=matplotlib.transforms.blended_transform_factory(
        axs[0].transData,
        axs[0].transAxes,
    ),
    clip_on=False,
)
axs[0].plot( # mark errors as vertical bars
    poles,
    np.ones_like(poles)+0.075,
    "x",
    mfc='none',
    color='black',
    transform=matplotlib.transforms.blended_transform_factory(
        axs[0].transData,
        axs[0].transAxes,
    ),
    clip_on=False,
)

for mode, c in enumerate(["green", "orange", "red"]):
    w, FN2, mag, a, b = ellip_filter(N, mode=mode)
    axs[1].plot(w, mag, linewidth=1, color=c)

axs[1].add_patch(Rectangle(
    (0, np.sqrt(2)/2),
    1, 1,
    fc ='green',
    alpha=0.2,
    lw = 10,
))
axs[1].add_patch(Rectangle(
    (1, 0.1),
    0.00992, np.sqrt(2)/2 - 0.1,
    fc ='orange',
    alpha=0.2,
    lw = 10,
))

axs[1].add_patch(Rectangle(
    (1.00992, 0),
    1, 0.1,
    fc ='red',
    alpha=0.2,
    lw = 10,
))

axs[0].set_xlim([0,2])
axs[0].set_ylim([1e-4,1e6])
axs[0].tick_params(bottom = False)
axs[0].grid()
axs[0].set_ylabel("$|F_N(w)|^2$")
axs[1].grid()
axs[1].set_ylim([0,1])
axs[1].set_ylabel("$|H(w)|$")
axs[1].set_xlabel("$w$")
plt.tight_layout()
plt.savefig("elliptic.pgf")
plt.show()

print("zeros", a)
print("poles", b)




