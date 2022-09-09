# -*- coding: utf-8 -*-
"""
date of creation: Fri Aug 26 08:59:36 2022
-------------------------------------------------
@author : Manuel Cattaneo
@contact: cattaneo.manuel@hotmail.com
-------------------------------------------------    

Description:
    Program to show the normal 1D Fourier decomposition with
    a square signal 
    c_{2n+1} =  

Modules:
"""
import numpy as np
from scipy.fft import fft, fftfreq
from scipy.signal import square

from matplotlib import rc
import matplotlib.pylab as plt

rc('font', **{'family': 'serif', 'serif': ['Computer Modern']})
rc('text', usetex=True)
"""
------------------------------------------------------------------------------
"""

if __name__ == '__main__':
    FONTSIZE_TICK  = 25
    FONTSIZE_LABEL = 30
    
    # Define two colors
    green      = np.array([60/255,150/255,16/255])   
    background = np.ones(shape=green.shape)
    
    # Choose sampling frequency 
    f_s = 10000
    T   = 1/f_s
    N   = int(1.0/T)
    
    # Square wave frequency
    f_signal = 2 #[Hz]
    
    # Compute x and y arrays
    x = np.linspace(0.0, 1.0, N, endpoint=False)
    y = square(2*np.pi* f_signal * x)
    
    # Compute spectrum + frequency ax + abs. value of spectrum
    y_f = fft(y)
    x_f = fftfreq(N, T)[:N//2]
    spectrum_abs = np.abs(y_f[0:N//2])/N
    
    fig , axs = plt.subplots(2,2, gridspec_kw={'width_ratios': [1, 0.05]})      
    fig.subplots_adjust(top=0.975,
                        bottom=0.05,
                        left=0.05,
                        right=0.925,
                        hspace=0.150,
                        wspace=0.05)

    hat_signal   = 0
    n_components = 0
    n_components_max = 5
    idxs = np.where(spectrum_abs > 0.005)
    
    # For loop to:
    # - take all the values of the spectrum which are greather than
    #   0.005 and draw a stem to the respective frequency 
    # - compute the fourier reconstruction of the signal using a sum of sine 
    #   waves for each stem point.
    for A,f in zip(spectrum_abs[idxs], x_f[idxs]):
        markerline, stemlines, baseline = axs[1,0].stem(f,A)
        # set properties of stem
        plt.setp(markerline, color=green, markersize=10)
        plt.setp(stemlines,  color=green, linewidth=5)
        
        if n_components < n_components_max:
            # compute reconstructed signal by summing up sine waves
            hat_signal += 2*A*np.sin(2*np.pi* f *x)
            n_components += 1
            
            # plot reconstructed signal step by step (from single sine 
            # to square wave)
            axs[0,0].plot(x, hat_signal, color=green,
                          linewidth=3.5,
                          alpha=n_components/(n_components_max))
        
    # Plot the square wave + set tick font
    axs[0,0].plot(x,y, linewidth=4, color=green)
    axs[0,0].tick_params(labelsize=FONTSIZE_TICK)
    
    axs[1,0].tick_params(labelsize=FONTSIZE_TICK)
    axs[1,0].set_xlim([0,100])
    axs[1,0].set_ylim([0,0.7])
    axs[1,1].set_visible(False)
    
    # Color Bar stuff
    from matplotlib.colors   import ListedColormap
    from matplotlib.colorbar import ColorbarBase              
    
    rgb_green = np.array([0.2*green + 0.8*background,
                          0.4*green + 0.6*background,
                          0.6*green + 0.4*background,
                          0.8*green + 0.2*background,
                          1.0*green + 0.0*background])
    
    my_cmap = ListedColormap(rgb_green)
    cbar = ColorbarBase(axs[0,1], cmap=my_cmap)
    cbar.ax.set_yticklabels(["$n=1$", "$n=2$", "$n=3$", "$n=4$", "$n=\infty$"], 
                            fontsize = FONTSIZE_LABEL)
 
        




    
    