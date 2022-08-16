import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches
import matplotlib.transforms
import matplotlib.text
from matplotlib.animation import FuncAnimation
import imageio

from simulation import Simulation


class Mass:
    def __init__(self, x_0, width, height, **kwargs):
        self._x_0 = x_0
        xy = (x_0, 0)
        self._rect = matplotlib.patches.Rectangle(xy, width, height, **kwargs)

    @property
    def patch(self):
        return self._rect

    @property
    def x(self):
        return self._rect.get_x()

    @property
    def width(self):
        return self._rect.get_width()

    def move(self, x):
        self._rect.set_x(self._x_0 + x)


class Spring:
    def __init__(self, n, height, ax, resolution=1000, **kwargs):
        self._n = n
        self._height = height
        self._N = resolution
        (self._line,) = ax.plot([], [], "-", **kwargs)

    def set(self, x_0, x_1):
        T = (x_1 - x_0) / self._n
        x = np.linspace(x_0, x_1, self._N, endpoint=True)
        t = np.linspace(0, x_1 - x_0, self._N)
        y = (np.sin(2 * np.pi * t / T) + 1.5) * self._height / 2
        self.line.set_data(x, y)

    @property
    def line(self):
        return self._line


class LinePlot:
    def __init__(self, ax, **kwargs):
        (self._line,) = ax.plot([], [], "-", **kwargs)
        self._x = []
        self._y = []

    @property
    def line(self):
        return self._line

    def update(self, x, y):
        self._x.append(x)
        self._y.append(y)
        self._line.set_data(self._x, self._y)


class ScatterPlot:
    def __init__(self, ax, **kwargs):
        self._color = kwargs.get("color", "tab:green")
        self._line = ax.scatter([], [], **kwargs)
        self._ax = ax
        self._x = []
        self._y = []

    @property
    def line(self):
        return self._line

    def update(self, x, y, **kwargs):
        self._x.append(x)
        self._y.append(y)
        self._line.remove()
        self._line = self._ax.scatter(self._x, self._y, color=self._color, **kwargs)


class QuiverPlot:
    def __init__(self, ax, **kwargs):
        self.x = []
        self.y = []
        self.u = []
        self.v = []
        self.ax = ax
        self.ln = self.ax.quiver([], [], [], [])

    def update(self, x, y, u, v):
        self.x.append(x)
        self.y.append(y)
        self.u.append(u)
        self.v.append(v)
        self.ln.remove()
        self.ln = self.ax.quiver(self.x, self.y, self.u, self.v)

    @property
    def line(self):
        return self.ln


anim_folder = "anim_0"
img_counter = 0

sim = Simulation()
params = {
    "x_0": [2, -2],
    "k_1": 1,
    "k_c": 2,
    "k_2": 1,
    "m_1": 0.5,
    "m_2": 0.5,
}

time = 2.1


# create axis
fig = plt.figure(figsize=(20, 15), constrained_layout=True)
fig.suptitle(
    " ,".join([f"${key} = {val}$" for (key, val) in params.items()]), fontsize=20
)
spec = fig.add_gridspec(3, 4)
ax0 = fig.add_subplot(spec[-1, :])
ax1 = fig.add_subplot(spec[:-1, :2])
ax2 = fig.add_subplot(spec[:-1, 2:])

ax0.set_yticks([])

mass_height = 0.5
spring_height = 0.6 * mass_height
x_max = 21
y_max = 2 * mass_height

mass_1 = Mass(
    7,
    2,
    mass_height,
    color="tab:red",
)
mass_2 = Mass(14, 2, mass_height, color="tab:blue")
masses = [mass_1, mass_2]
patches = [mass.patch for mass in masses]

spring_1 = Spring(4, spring_height, ax0, color="tab:red", linewidth=10)
spring_2 = Spring(4, spring_height, ax0, color="tab:gray", linewidth=10)
spring_3 = Spring(4, spring_height, ax0, color="tab:blue", linewidth=10)
springs = [spring_1, spring_2, spring_3]

linePlot_1 = LinePlot(ax1, color="tab:red", label="$m_1$", alpha=1)
linePlot_2 = LinePlot(ax1, color="tab:blue", label="$m_2$", alpha=1)
linePlots = [linePlot_1, linePlot_2]

# quiverPlot = QuiverPlot(ax2)
scatterPlot = ScatterPlot(ax2)

lines = [spring.line for spring in springs]
lines.extend([plot.line for plot in linePlots])
# lines.append(quiverPlot.line)
lines.append(scatterPlot.line)

objects = lines + patches

ax0.plot(
    np.repeat(mass_1.x, 2),
    [0, y_max],
    "--",
    color="tab:red",
    label="Ruhezustand $m_1$",
)
ax0.plot(
    np.repeat(mass_2.x, 2),
    [0, y_max],
    "--",
    color="tab:blue",
    label="Ruhezustand $m_2$",
)


def init():
    ax0.set_xlim(0, x_max)
    ax0.set_ylim(0, y_max)

    ax1.set_xlim(0, time)
    ax1.set_ylim(-4, 4)
    ax1.set_xlabel("time", fontsize=20)
    ax1.set_ylabel("$q$", fontsize=20)

    ax2.set_xlim(-4, 4)
    ax2.set_ylim(-4, 4)
    ax2.set_xlabel("$q_1$", fontsize=20)
    ax2.set_ylabel("$q_2$", fontsize=20)

    for patch in patches:
        ax0.add_patch(patch)

    spring_1.set(0, mass_1.x)
    spring_2.set(mass_1.x + mass_1.width, mass_2.x)
    spring_2.set(mass_2.x + mass_2.width, x_max)

    return objects


def update(frame):
    global img_counter
    x_1, x_2 = sim(frame, **params)

    mass_1.move(x_1)
    mass_2.move(x_2)

    spring_1.set(0, mass_1.x)
    spring_2.set(mass_1.x + mass_1.width, mass_2.x)
    spring_3.set(mass_2.x + mass_2.width, x_max)

    linePlot_1.update(frame, x_1)
    linePlot_2.update(frame, x_2)

    scatterPlot.update(x_1, x_2, alpha=0.25)

    img_counter += 1
    return objects


anim = FuncAnimation(
    fig,
    update,
    frames=np.linspace(0, time, int(time * 30)),
    init_func=init,
    blit=False,
)

ax0.legend(fontsize=20)
ax1.legend(fontsize=20)
FFwriter = matplotlib.animation.FFMpegWriter(fps=30)
anim.save("animation.mp4", writer=FFwriter)
