# Software for Shape uncertainty quantification of Maxwell eigenvalues and -modes with application to TESLA cavities

This repository contains the Software complementing the Paper "Shape uncertainty quantification of Maxwell eigenvalues and -modes with application to TESLA cavities" by Jürgen Dölz, David Ebert, Sebastian Schöps and Anna Ziegler [1].

[1] J. Dölz, D. Ebert, S. Schöps, A. Ziegler, Shape uncertainty quantification of Maxwell eigenvalues and -modes with application to TESLA cavities. Cornell University, ARXIV: [2401.11890](https://arxiv.org/abs/2401.11890), 2024.

## The repository contains: 
-Demo_Misaligned_Cavity.m to compute and visualize deformed cavities based on random realizations using the deformation modes as identified by the Karhunen-Loève decomposition in [2].

-generateConvergencePlots1_9.m to visualize the convergence plots of the error of the expected value and covariances w.r.t. the Monte Carlo method. This script plots the results for the first nine eigenmodes, which belong to eigenvalues of simple multiplicity.

-generateConvergencePlots10_18.m to visualize the convergence plots of the error of the expected value and covariances w.r.t. the Monte Carlo method. This script plots the results for the eigenmodes 10-18, which belong to 9 eigenvalues of multiplicity two.

[2] N. Georg, W. Ackermann, J. Corno, S. Schöps, Uncertainty quantification for Maxwell’s eigenproblem based on isogeometric analysis and mode tracking, Computer Methods in Applied Mechanics and Engineering, vol. 350, 2019, pp. 228-244, https://doi.org/10.1016/j.cma.2019.03.002. ARXIV: [1802.02978](https://arxiv.org/abs/1802.02978).


## Requirements
The code was developed using Matlab R2022a and GeoPDEs in Version 3.2.0 [3, 4] and the NURBS package in Version 1.4.1. [5].
Running the example code Demo_Misaligned_Cavity.m requires the NURBS package.

[3] R. Vázquez, A new design for the implementation of isogeometric analysis in Octave and Matlab: GeoPDEs 3.0, Computers & Mathematics with Applications, Volume 72, Issue 3, 2016, Pages 523-554.

[4] C. de Falco, A. Reali, and R. Vazquez. GeoPDEs: A research tool for isogeometric analysis of PDEs. Advances in Engineering Software, 42(12):1020-1034, 2011.

[5] M. Spink, D. Claxton, C. de Falco, R. Vazquez, The NURBS toolbox, http://octave.sourceforge.net/nurbs/index.html.

[6] The Mathworks, Inc., Natick, Massachusetts, Symbolic Math Toolbox (R2022a), 2022.


## Acknowledgment

The work of SSc and AZ is partially supported by the Graduate School CE within the Centre for Computational Engineering at TU Darmstadt. The work of JD and DE was partially funded by the Deutsche Forschungsgemeinschaft (DFG, German Research Foundation) – project number 501419255. JD and DE also thankfully acknowledge the support by the DFG under Germany’s Excellence Strategy – project number 390685813. We thank Jacopo Corno for providing us with the code and data to analyze the misaligned TESLA cavities. We also thank Christian Schmitt for his frequent support with running our code on the compute server.

## License
This repository is licensed under the GNU General Public License v3.0.
