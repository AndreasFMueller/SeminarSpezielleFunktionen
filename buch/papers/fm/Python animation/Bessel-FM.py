import numpy as np
from scipy import signal
from scipy.fft import fft, ifft, fftfreq
import scipy.special as sc
import scipy.fftpack
import matplotlib.pyplot as plt
from matplotlib.widgets import Slider

# Number of samplepoints
N = 600
# sample spacing
T = 1.0 / 800.0
x = np.linspace(0.01, N*T, N)
beta = 1.0
y_old = np.sin(100.0 * 2.0*np.pi*x+beta*np.sin(50.0 * 2.0*np.pi*x))
y = 0*x;
xf = fftfreq(N, 1 / 400)
for k in range (-5, 5):
    y = sc.jv(k,beta)*np.sin((100.0+k*50) * 2.0*np.pi*x)
    yf = fft(y)
    plt.plot(xf, np.abs(yf))

axbeta =plt.axes([0.25, 0.1, 0.65, 0.03])
beta_slider = Slider(
ax=axbeta,
label="Beta",
valmin=0.1,
valmax=3,
valinit=beta,
)

def update(val):
    line.set_ydata(fm(beta_slider.val))
    fig.canvas.draw_idle()


beta_slider.on_changed(update)
plt.show()

yf_old = fft(y_old)
plt.plot(xf, np.abs(yf_old))
plt.show()