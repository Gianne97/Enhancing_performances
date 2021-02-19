function [m, n, s, e] = MAR(N, p)
%MAR This function evaluates the MAR algorithm as requested by the
%Para-CORDIC algorithm
%   N is the bit-length of the input
%   p is the error tolerant parameter
%   
%   m is a parameter given by ceil((N-log2(3))/3)
%
%   n contains the number of coefficient for a given power of two.
%       It corresponds to n(i)
%
%   s contains the coefficient used for approximating a given power of two.
%       It corresponds to s_i^j
%   
%   e contains the errors for a given i.
%       It corresponds to e_i

m = ceil((N-log2(3))/3);

if not((m <= p)&&(p <= N))
    printf("Invalid p")
    return
end

indexes = 1:(m-1);
n = ones(1, m-1);
s = zeros(m, m-1);
s(1, :) = indexes;

e = 2.^(-indexes) - atan(2.^(-indexes)); % vector of initial errors
arctang = atan(2.^(-(1:N)));

while sum(e) > 2^(-p)
    [e_M, idx] = max(e);
    n(idx) = n(idx) + 1; % n is increased by one
    tmp = e_M - arctang;
    aux = min(tmp(tmp>0));
    if length(aux) <1
        return
    end
    e(idx) = aux; % take the minimum between the positive values
    q = find(tmp>0, 1); % find the index of the first positive value
    s(n(idx), idx) = q;
end

end

