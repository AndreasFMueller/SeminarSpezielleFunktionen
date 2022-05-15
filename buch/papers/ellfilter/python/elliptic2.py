# %%

import matplotlib.pyplot as plt
import scipy.signal
import numpy as np
import matplotlib
from matplotlib.patches import Rectangle


def ellip_filter(N):

    order = N
    passband_ripple_db = 3
    stopband_attenuation_db = 20
    omega_c = 1000

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

    w, mag_db, phase = scipy.signal.bode((a, b), w=np.linspace(0*omega_c,2*omega_c, 4000))

    mag = 10**(mag_db/20)

    passband_ripple = 10**(-passband_ripple_db/20)
    epsilon2 = (1/passband_ripple)**2 - 1

    FN2 = ((1/mag**2) - 1)

    return w/omega_c, FN2 / epsilon2


plt.figure(figsize=(4,2.5))

for N in [5]:
    w, FN2 = ellip_filter(N)
    plt.semilogy(w, FN2, label=f"$N={N}$")

plt.gca().add_patch(Rectangle(
    (0, 0),
    1, 1,
    fc ='green',
    alpha=0.2,
    lw = 10,
))
plt.gca().add_patch(Rectangle(
    (1, 1),
    0.01, 1e2-1,
    fc ='green',
    alpha=0.2,
    lw = 10,
))

plt.gca().add_patch(Rectangle(
    (1.01, 100),
    1, 1e6,
    fc ='green',
    alpha=0.2,
    lw = 10,
))
plt.xlim([0,2])
plt.ylim([1e-4,1e6])
plt.grid()
plt.xlabel("$w$")
plt.ylabel("$F^2_N(w)$")
plt.legend()
plt.savefig("F_N_elliptic.pdf")
plt.show()



