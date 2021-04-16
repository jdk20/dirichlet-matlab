# dirichlet-matlab
MATLAB functions to generate random vectors from a Dirichlet distribution or to calculate the pdf from a Dirichlet distribution with given hyperparameters (A).

## Installation
You can add the dirichlet-matlab directory to your MATLAB search path:
```matlab
addpath(genpath('dirichlet-matlab'))  
```

## Example
```matlab
A = [2, 3, 4]; % Dirichlet hyperparameters (shape vector) for a 3-dimensional distribution

X = dirrnd(A, 5); % Generate 5 random vectors
X =
   0.165180831562802   0.572367339824971   0.262451828612227
   0.107682875327566   0.410558528169850   0.481758596502584
   0.124892099736948   0.230780581503848   0.644327318759204
   0.236682038827591   0.444503367825342   0.318814593347067
   0.407190742512644   0.164892120689403   0.427917136797953
   
Y = dirpdf(X, A); % Find pdf for X
Y =
   3.286982736584238
   6.819059741097087
   5.978502390713254
   5.091775747161138
   2.914848702465950
   
[M,V] = dirstat(A); % Mean and variance for each dimension
M =
   0.222222222222222   0.333333333333333   0.444444444444444
V =
   0.017283950617284   0.022222222222222   0.024691358024691
```