import numpy as np
import matplotlib.pyplot as plt


@np.vectorize
def fn(x):
    return (x ** 2) * 2 / 100 + (1 + x / 4) + np.sin(x)

@np.vectorize
def ddfn(x):
    return 2 * 5 / 100 - np.sin(x)

x = np.linspace(0, 10, 500)
y = fn(x)
ddy = ddfn(x)

cmap = ddy - np.min(ddy)
cmap = cmap * 1000 / np.max(cmap)

plt.plot(x, y)
plt.plot(x, ddy)
# plt.plot(x, cmap)

plt.show()

fname = "curvature-1d.dat"
np.savetxt(fname, np.array([x, y, cmap]).T, delimiter="  ")

# with open(fname, "w") as f:
#     # f.write("x   y   cmap\n")
#     for xv, yv, cv in zip(x, y, cmap):
#         f.write(f"{xv}   {yv}   {cv}\n")
