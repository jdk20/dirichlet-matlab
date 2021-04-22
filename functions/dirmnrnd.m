function r = dirmnrnd(a,n,varargin)
%DIRRND Random vectors from a Dirichlet-multinomial distribution.
%   R = DIRMNRND(A,N) returns a random vector chosen from the 
%   Dirichlet-multinomial distribution with a 1-by-K vector of hyperparameters 
%   A and N, where K is the dimensionality of the pdf and N is positive 
%   integer. R is a 1-by-K vector. If A <= 0 or N <= 0, R is a 
%   1-by-K vector of NaN values.
%
%   R = DIRMNRND(A,N,M) returns M random vectors chosen from the 
%   Dirichlet-multinomial distribution with hyperparameters A and N. R is a 
%   M-by-K matrix. Each row of R corresponds to one random vector.
%
%   Example:
%    Generate 10 random vectors with hyperparameters A and N
%    A=[2.1,3.5,4.8];
%    N=20;
%    R=dirmnrnd(A,N,10);
%
%   See also DIRMNPDF, DIRMNSTAT.

%   References:
%      [1] B. Frigyik, et. al., "Introduction to the Dirichlet Distribution and 
%          Related Processes", UWEE Technical Report, 2010


narginchk(2, 3);

if ~isvector(a)
    error('Hyperparameter A must be a vector.');
end

if ~isscalar(n)
    error('Hyperparameter N must be a scalar.');
end

if iscolumn(a)
    a = transpose(a);
end

if ~isempty(varargin)
    m = varargin{:};
else
    m = 1;
end

if any(a <= 0) || any(n <= 0) || any(n ~= floor(n))
    r = NaN(m, size(a, 2));
else
    p = dirrnd(a, m);
    r = mnrnd(n, p, m);
end