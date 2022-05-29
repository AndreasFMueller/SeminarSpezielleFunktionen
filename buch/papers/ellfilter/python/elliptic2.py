# %%

import matplotlib.pyplot as plt
import scipy.signal
import numpy as np
import matplotlib
from matplotlib.patches import Rectangle

import plot_params

def ellip_filter(N):

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

    w, mag_db, phase = scipy.signal.bode((a, b), w=np.linspace(0*omega_c,2*omega_c, 4000))

    mag = 10**(mag_db/20)

    passband_ripple = 10**(-passband_ripple_db/20)
    epsilon2 = (1/passband_ripple)**2 - 1

    FN2 = ((1/mag**2) - 1)

    return w/omega_c, FN2 / epsilon2, mag, a, b


plt.figure(figsize=(4,2.5))

for N in [5]:
    w, FN2, mag, a, b = ellip_filter(N)
    plt.semilogy(w, FN2, label=f"$N={N}, k=0.1$", linewidth=1)

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
    fc ='orange',
    alpha=0.2,
    lw = 10,
))

plt.gca().add_patch(Rectangle(
    (1.01, 100),
    1, 1e6,
    fc ='red',
    alpha=0.2,
    lw = 10,
))

zeros = [0,0.87,1]
poles = [1.01,1.155]

import matplotlib.transforms
plt.plot( # mark errors as vertical bars
    zeros,
    np.zeros_like(zeros),
    "o",
    mfc='none',
    color='black',
    transform=matplotlib.transforms.blended_transform_factory(
        plt.gca().transData,
        plt.gca().transAxes,
    ),
)
plt.plot( # mark errors as vertical bars
    poles,
    np.ones_like(poles),
    "x",
    mfc='none',
    color='black',
    transform=matplotlib.transforms.blended_transform_factory(
        plt.gca().transData,
        plt.gca().transAxes,
    ),
)

plt.xlim([0,2])
plt.ylim([1e-4,1e6])
plt.grid()
plt.xlabel("$w$")
plt.ylabel("$F^2_N(w)$")
plt.legend()
plt.tight_layout()
plt.savefig("F_N_elliptic.pgf")
plt.show()



plt.figure(figsize=(4,2.5))
plt.plot(w, mag, linewidth=1)

plt.gca().add_patch(Rectangle(
    (0, np.sqrt(2)/2),
    1, 1,
    fc ='green',
    alpha=0.2,
    lw = 10,
))
plt.gca().add_patch(Rectangle(
    (1, 0.1),
    0.01, np.sqrt(2)/2 - 0.1,
    fc ='orange',
    alpha=0.2,
    lw = 10,
))

plt.gca().add_patch(Rectangle(
    (1.01, 0),
    1, 0.1,
    fc ='red',
    alpha=0.2,
    lw = 10,
))

plt.grid()
plt.xlim([0,2])
plt.ylim([0,1])
plt.xlabel("$w$")
plt.ylabel("$|H(w)|$")
plt.tight_layout()
plt.savefig("elliptic.pgf")
plt.show()

print("zeros", a)
print("poles", b)




