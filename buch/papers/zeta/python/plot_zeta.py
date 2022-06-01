import numpy as np
from mpmath import zeta
import matplotlib.pyplot as plt
from matplotlib import colors
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

print(zeta(-1))
print(zeta(-1 + 2j))

re_values = np.arange(-10, 5, 0.04)
im_values = np.arange(-20, 20, 0.04)
plot_matrix = np.zeros((len(im_values), len(re_values), 3))
for im_i, im in enumerate(im_values):
    print(im_i)
    for re_i, re in enumerate(re_values):
        z = complex(zeta(re + 1j*im))
        h = (np.angle(z) + np.pi) / (2*np.pi)
        v = np.abs(z)
        s = 1.0
        plot_matrix[im_i, re_i] = [h, s, v]

log10_v = np.log10(plot_matrix[:, :, 2])
log10_v += np.abs(np.min(log10_v))
plot_matrix[:, :, 2] = (log10_v) / np.max(log10_v)
plt.imshow(colors.hsv_to_rgb(plot_matrix), extent=[re_values.min(), re_values.max(), im_values.min(), im_values.max()])
plt.xlabel("$\Re$")
plt.ylabel("$\Im$")
plt.savefig(f"zeta_color_plot.pgf")
