function y = dirmnpmf(x,a)
%DIRPDF Dirichlet-multinomial probability mass function (pmf).
%   Y = DIRMNPMF(X,A) returns the pdf for the Dirichlet-multinomial 
%   distribution with the hyperparameter A, evaluated at each row of X. X and A 
%   are M-by-K matrices or 1-by-K vectors, where K is the dimensionality of the 
%   of the Dirichlet-multinomial distribution. Each row of X must consist of 
%   integers, with X > 0, and hyperparameter A > 0. Y is a M-by-1 vector, and 
%   DIRMNPMF computes each row of Y using the corresponding row of the inputs, 
%   or replicates them if needed.
%
%   Example:
%    Generate 10 random vectors with hyperparameter A and compute the 
%    Dirichlet-multinomial pmf of X with the same hyperparameter A
%    A = [2, 3, 4];
%    N = 5;
%    X = dirmnrnd(A, N, 10);
%    Y = dirmnpmf(X, A);
%
%   See also DIRMNRND, DIRMNSTAT.

%   References:
%      [1]  A. Gelman, et. al., "Bayesian Data Analysis", CRC Press, 2013
%      [2] B. Frigyik, et. al., "Introduction to the Dirichlet Distribution and 
%          Related Processes", UWEE Technical Report, 2010


narginchk(2, 2);

if iscolumn(a)
    a = transpose(a);
end

if iscolumn(x)
    x = transpose(x);
end

[m, j] = size(x);
[n, k] = size(a);

if j < 2 || k < 2
    error('Dimensionality must be greater than or equal to 2.');
end

if j ~= k
    error('Requires input and parameter to match in dimension.');
end

if m ~= n && m > 1 && n > 1
    error('Requires input and parameter to match in number of samples.');
end

if m == 1 && n > 1
    x = repmat(x, [n, 1]);
elseif m > 1 && n == 1
    a = repmat(a, [m, 1]);
end

y = zeros(size(x, 1), 1, 'like', x);

% Return NaN for input or parameter violations
i0 = any(a <= 0, 2) | any(x < 0, 2) | any(x ~= floor(x), 2);
y(i0) = NaN;

% Compute logs
i1 = ~i0;
a0 = sum(a(i1,:), 2);
n0 = sum(x(i1,:), 2);
y(i1) = exp((gammaln(a0) + gammaln(n0+1)) - gammaln(n0 + a0) + ...
    sum(gammaln(x(i1,:) + a(i1,:)) - (gammaln(a(i1,:)) + ...
    gammaln(x(i1,:) + 1)), 2));