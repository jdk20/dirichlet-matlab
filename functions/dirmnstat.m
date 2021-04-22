function [m,v,cv] = dirmnstat(a,n)
%DIRMNSTAT Mean, variance, and covariance for the Dirichlet-multinomial 
%   distribution. 
%   [M,V,CV] = DIRMNSTAT(A,N) returns the mean, variance, and covariance of the 
%   Dirichlet-multinomial distribution with hyperparameters A and N. M and V 
%   are 1-by-K vectors where K is the dimensionality of the 
%   Dirichlet-multinomial distribution. CV is a K-by-K matrix where the 
%   diagonal is the variance of A.
%
%   See also DIRMNPDF, DIRMNRND.
    
%   References:
%      [1] A. Gelman, et. al., "Bayesian Data Analysis", CRC Press, 2013
%      [2] B. Frigyik, et. al., "Introduction to the Dirichlet Distribution and 
%          Related Processes", UWEE Technical Report, 2010


narginchk(2, 2);

if ~isvector(a)
    error('Hyperparameter A must be a vector.');
end

if ~isscalar(n)
    error('Hyperparameter N must be a scalar.');
end

if iscolumn(a)
    a = transpose(a);
end

if any(a <= 0) || any(n <= 0) || any(n ~= floor(n))
    m = NaN(1, length(a));
    v = NaN(1, length(a));
    cv = NaN(length(a), length(a));
else
    a0 = sum(a);
    
    m = n*(a./a0);
    
    v = n.*(a./a0).*(1 - a./a0).*((n+a0)/(1+a0));
    
    cv = zeros(length(a), length(a));
    for i = 1:length(a)
        for j = 1:length(a)
            if i == j
                cv(i,j) = v(i);
            else
                cv(i,j) = -n.*((a(i)*a(j))/(a0^2)).*((n+a0)/(1+a0));
            end
        end
    end
end