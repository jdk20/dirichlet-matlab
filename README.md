# dirichlet-matlab

MATLAB functions to generate random vectors from a Dirichlet distribution or to calculate the pdf from a Dirichlet distribution with a given concentration parameter.

## Installation
You can add the dirichlet-matlab directory to your MATLAB search path:
```matlab
addpath(genpath('dirichlet-matlab'))  
```

## Example
```matlab
A = [2, 3, 4]; % Concentration parameter

X = dirrnd(A, 3); % Generate 3 random vectors for a 3 dimensional distribution
X =
   0.268488024881241   0.367706248893684   0.363805726225075
   0.497208112970622   0.161405294886224   0.341386592143154
   0.240196504393133   0.339932582842612   0.419870912764255
   
Y = dirpdf(X, A); % Find pdf for X
Y =
   5.873200265723199
   1.731619309449591
   6.903016572663383
   
[M,V] = dirstat(A); % Mean and variance for each dimension
M =
   0.222222222222222   0.333333333333333   0.444444444444444
V =
   0.017283950617284   0.022222222222222   0.024691358024691
```