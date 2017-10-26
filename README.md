# 2D CT reconstruction algorithms
This is a toolbox to compare different regularisation methods for 2D CT reconstruction. It was written as part of my undergraduate project at the University of Manchester.

There are four different reconstruction algorithms implemented:

### Iterative methods:
1. L2-penalised (Tikhonov)
2. L1-penalised
3. Isotropic TV-penalised
4. L2-TV penalised

### Direct method:
1. Filtered backprojection with varying low-pass filter

I did not have time to write my own forward- and back-projection matrix, so the Radon transform is implemented using matlabs "radon(P, theta)" function, and the back-projection operator is implemented using "iradon(P, theta, 'linear', 'none')".
Isotropic TV-penalised reconstruction is implemented using the algorithm from Beck and Teboulle's paper "Fast Gradient-Based Algorithms for Constrained Total Variation Image Denoising and Deblurring Problems".
