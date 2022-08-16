import numpy as np
from mpmath import zeta
import matplotlib.pyplot as plt
import matplotlib
matplotlib.use("pgf")
matplotlib.rcParams.update(
    {
        "pgf.texsystem": "pdflatex",
        "font.family": "serif",
        "font.size": 8,
        "text.usetex": True,
        "pgf.rcfonts": False,
        "axes.unicode_minus": False,
    }
)
# const re plot
re_values = [-1, 0, 0.5]
im_values = np.arange(0, 40, 0.04)
buf = np.zeros((len(re_values), len(im_values), 2))
for im_i, im in enumerate(im_values):
    print(im_i)
    for re_i, re in enumerate(re_values):
        z = complex(zeta(re + 1j*im))
        buf[re_i, im_i] = [np.real(z), np.imag(z)]

for i in range(len(re_values)):
    plt.figure()
    plt.plot(buf[i,:,0], buf[i,:,1], label=f"$\Re={re_values[i]}$")
    plt.xlabel("$\Re$")
    plt.ylabel("$\Im$")
    plt.savefig(f"zeta_re_{re_values[i]}_plot.pgf")
