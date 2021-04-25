function X = dirproc(a,N)
%DIRPROC Truncated samples from the Dirichlet process.
%   X = DIRPROC(A,N) returns Dirichlet process samples over the sequence of 
%   natural numbers using the Polya Urn method. A is a real positive scalar 
%   parameter and N a non-negative integer representing the number of 
%   iterations.
    
%   References:
%      [1] A. Gelman, et. al., "Bayesian Data Analysis", CRC Press, 2013
%      [2] B. Frigyik, et. al., "Introduction to the Dirichlet Distribution and 
%          Related Processes", UWEE Technical Report, 2010


narginchk(2, 2);

if ~isscalar(a) || a <= 0
    error('Hyperparameter A must be a positive real scalar.');
end

if ~isscalar(N) || N <= 0 || floor(N) ~= N
    error('Hyperparameter N must be a positive real integer.');
end

X = NaN(N, 1); % Output sequence of states
Nx = []; % Number of occurences for each state
s = 1; % Sequence of natural numbers
for n = 1:N
    % Probability for creating a new state
    p = NaN(1 + length(Nx), 1);
    p(1) = a/(a + n - 1);
    
    % Probability for emitting a previously seen state
    p(2:end) = Nx./(a + n - 1);
    
    % Random draw
    idx = randsample(1:length(p), 1, true, p);

    % Creating a new state
    if idx == 1
        X(n) = s; % Iterate over sequence of natural numbers
        s = s + 1;

        Nx = [Nx; 1]; % Add new state
    else % Emit a previously seen state
        X(n) = idx-1; % Add state to output sequence
        Nx(idx-1) = Nx(idx-1) + 1; % Increase occurance of that state
    end
end