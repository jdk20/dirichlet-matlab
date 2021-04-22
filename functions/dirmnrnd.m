function r = dirmnrnd(a,x,varargin)
%DIRRND Random vectors from a Dirichlet-multinomial distribution.
%   R = DIRMNRND(A,X) returns a random vector chosen from the 
%   Dirichlet-multinomial distribution with a 1-by-K vector of hyperparameters 
%   A and X, where K is the dimensionality of the pdf and X is a vector of 
%   non-negative integers. R is a 1-by-K vector. If A <= 0 or X < 0, R is a 
%   1-by-K vector of NaN values.
%
%   R = DIRMNRND(A,X,M) returns M random vectors chosen from the 
%   Dirichlet-multinomial distribution with hyperparameters A and X. R is a 
%   M-by-K matrix. Each row of R corresponds to one random vector.
%
%   Example:
%    Generate 10 random vectors with hyperparameters A and X
%    A=[2.1,3.5,4.8];
%    X=[2,2,5];
%    R=dirmnrnd(A,X,10);
%
%   See also DIRMNPDF, DIRMNSTAT.


narginchk(2, 3);

if ~isvector(a) || ~isvector(x)
    error('Hyperparameters must be a vector.');
end

if iscolumn(a)
    a = transpose(a);
end

if iscolumn(x)
    x = transpose(x);
end

if ~isempty(varargin)
    m = varargin{:};
else
    m = 1;
end

if any(a <= 0) || any(x < 0) || any(x ~= floor(x))
    r = NaN(m, size(a, 2));
else
    r = dirrnd(a+x, m);
end