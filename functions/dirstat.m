function [m,v] = dirstat(a)
%DIRSTAT Mean and variance for the Dirichlet distribution.
%   [M,V] = DIRSTAT(A) returns the mean and variance of the Dirichlet 
%   distribution with hyperparameter A. M and V are 1-by-K vectors
%   where K is the dimensionality of the Dirichlet distribution.
%
%   See also DIRPDF, DIRRND.
    
%   References:
%      [1]  A. Gelman, et. al., "Bayesian Data Analysis", CRC Press, 2013


narginchk(1, 1);

if ~isvector(a)
    error('Hyperparameter must be a vector.');
end

if iscolumn(a)
    a = transpose(a);
end

if any(a <= 0)
    m = NaN(1, length(a));
    v = NaN(1, length(a));
else
    m = a./sum(a);
    v = (m.*(1 - m))/(sum(a) + 1);
end