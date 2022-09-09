# -*- coding: utf-8 -*-
"""
date of creation: Wed Sep  7 12:47:40 2022
-------------------------------------------------
@author : Manuel Cattaneo
@contact: cattaneo.manuel@hotmail.com
-------------------------------------------------    

Description:
    -

Modules:
"""
import cv2 as cv

import numpy as np

# from matplotlib import rc
import matplotlib.pylab as plt

"""
------------------------------------------------------------------------------
"""

if __name__ == '__main__':    
    img               = cv.imread('test_image.png')
    #rgb 2 grayscale
    img               = np.mean(img, axis=-1)
    
    img_fft           = np.fft.fft2(img)
    img_fft_shift     = np.fft.fftshift(img_fft)
    img_abs_fft_shift = 20*np.log(np.abs(img_fft_shift))
    
    img_ifft_phase = np.fft.ifft2(np.exp(1j*np.angle(img_fft)))
    img_ifft_abs   = np.fft.ifft2(np.abs(img_fft))

    fig, axs = plt.subplots(ncols=3)
    
    fig.subplots_adjust(top=0.984,
                        bottom=0.016,
                        left=0.01, 
                        right=0.992,
                        hspace=0.2,
                        wspace=0.032)

    axs[0].imshow(img, cmap='viridis')
    axs[0].set_xticks([])
    axs[0].set_yticks([])
    
    axs[1].imshow(np.abs(img_ifft_phase), cmap='viridis')
    axs[1].set_xticks([])
    axs[1].set_yticks([])
    
    axs[2].imshow(np.log(np.abs(img_ifft_abs)), cmap='viridis')
    axs[2].set_xticks([])
    axs[2].set_yticks([])
    