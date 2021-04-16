function y = dirpdf(x,a)
%DIRPDF Dirichlet probability density function (pdf).
%   Y = DIRPDF(X,A) returns the pdf for the Dirichlet distribution with the
%   concentration parameter A, evaluated at each row of X. X and A are M-by-K
%   matrices or 1-by-K vectors, where K is the dimensionality of the of the
%   Dirichlet distribution. Each row of X must sum to one, with 0 <= X <= 1,
%   and concentration parameter A > 0. Y is a M-by-1 vector, and DIRPDF computes
%   each row of Y using the corresponding row of the inputs, or replicates them
%   if needed.
%
%   Example:
%    Generate 10 random vectors with concentration parameter A and compute the 
%    Dirichlet pdf of X with the same concentration parameter A
%    A = [2, 3, 4];
%    X = dirrnd(A, 10);
%    Y = dirpdf(X, A);
%
%   See also DIRRND, DIRSTAT.

%   References:
%      [1]  A. Gelman, et. al., "Bayesian Data Analysis", CRC Press, 2013


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
i0 = any(a <= 0, 2) | any(x < 0, 2) | any(x > 1, 2) | ...
    (sum(x, 2) + eps(10) < 1) | (sum(x, 2) - eps(10) > 1);
y(i0) = NaN;

% Special case
i1 = any(x == 0 & a < 1, 2) & ~i0;
y(i1) = Inf;

% Compute accurate logs for small inputs
i2 = any(x > 0 & x < 0.1, 2) & ~i0 & ~i1;
y(i2) = exp(-(sum(gammaln(a(i2, :)), 2) - gammaln(sum(a(i2, :), 2))) + ...
        sum((a(i2, :) - 1).*log1p(x(i2, :) - 1), 2));

% Compute regular logs
i3 = ~i0 & ~i1 & ~i2;
y(i3) = exp(-(sum(gammaln(a(i3, :)), 2) - gammaln(sum(a(i3, :), 2))) + ...
        sum((a(i3, :) - 1).*log(x(i3, :)), 2));