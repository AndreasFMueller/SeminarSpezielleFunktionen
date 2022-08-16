import numpy as np
from scipy import signal
from scipy.fft import fft, ifft, fftfreq
import scipy.special as sc
import scipy.fftpack
import matplotlib.pyplot as plt
import matplotlib as mpl
# Use the pgf backend (must be set before pyplot imported)
mpl.use('pgf')

from matplotlib.widgets import Slider
def fm(beta):
    # Number of samplepoints
    N = 600
    # sample spacing
    T = 1.0 / 1000.0
    fc = 100.0
    fm = 30.0
    x = np.linspace(0.01, N*T, N)
    #beta = 1.0
    y_old = np.sin(fc * 2.0*np.pi*x+beta*np.sin(fm * 2.0*np.pi*x))
    y = 0*x;
    xf = fftfreq(N, 1 / N)
    for k in range (-4, 4):
        y = sc.jv(k,beta)*np.sin((fc+k*fm) * 2.0*np.pi*x)
        yf = fft(y)/(fc*np.pi)
        plt.plot(xf, np.abs(yf))
    plt.xlim(-150, 150)
    #plt.savefig('bessel.pgf', format='pgf')
    plt.show()

fm(1)

# Bessel-Funktion
for n in range (-2,4):
    x = np.linspace(-11,11,1000)
    y = sc.jv(n,x)
    plt.plot(x, y, '-',label='n='+str(n))
#plt.plot([1,1],[sc.jv(0,1),sc.jv(-1,1)],)
plt.xlim(-10,10)
plt.grid(True)
plt.ylabel('Bessel $J_n(\\beta)$')
plt.xlabel(' $ \\beta $ ')
plt.plot(x, y)
plt.legend()
#plt.show()
plt.savefig('bessel.pgf', format='pgf')
print(sc.jv(0,1))