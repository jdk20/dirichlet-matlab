function [m,mo,v,cv] = dirstat(a)
%DIRSTAT Mean, mode, variance, and covariance for the Dirichlet distribution.
%   [M,MO,V,CV] = DIRSTAT(A) returns the mean, mode, variance, and covariance of 
%   the Dirichlet distribution with hyperparameter A. M, MO, and V are 1-by-K
%   vectors where K is the dimensionality of the Dirichlet distribution. CV is 
%   a K-by-K matrix where the diagonal is the variance of A. The Dirichlet
%   is unimodal for where A > 1.
%
%   See also DIRPDF, DIRRND.
    
%   References:
%      [1] A. Gelman, et. al., "Bayesian Data Analysis", CRC Press, 2013
%      [2] B. Frigyik, et. al., "Introduction to the Dirichlet Distribution and 
%          Related Processes", UWEE Technical Report, 2010


narginchk(1, 1);

if ~isvector(a)
    error('Hyperparameter must be a vector.');
end

if iscolumn(a)
    a = transpose(a);
end

if any(a <= 0)
    m = NaN(1, length(a));
    mo = NaN(1, length(a));
    v = NaN(1, length(a));
    cv = NaN(length(a), length(a));
else
    a0 = sum(a);
    
    m = a./a0;
    mo = (a - 1)./(a0 - length(a));
    
    v = (m.*(1 - m))/(a0 + 1);
    
    cv = zeros(length(a), length(a));
    for i = 1:length(a)
        for j = 1:length(a)
            if i == j
                cv(i,j) = a(i)*(a0 - a(i));
            else
                cv(i,j) = -a(i)*a(j);
            end
        end
    end
    cv = cv./(a0^2*(a0 + 1));
end