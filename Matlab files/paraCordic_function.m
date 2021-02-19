function [x, y] = paraCordic_function(theta_rad, N, m, err, s, n, K)
%paraCordic_function This function simulates the paraCordic algorithm
%   This function returns the cosine x and the sine y of the input angle
%   theta. Moreover, it requires:
%   - N, number of precision bits
%   - m, ceil((N - log2(3))/3)
%   - err, vector containing the errors
%   - s, matrix containing the tangent values for the microrotations
%   - n, vector containing the number of microrotations
%   - K, scaling factor

% Starting vector
x = K;
y = 0;

% powers of two
p2 = 2.^(-(1:N));

theta = float2bin(theta_rad, N, 0);

% verification of the conversion
new_theta_rad = -theta(1) + sum(p2.*theta(2:end));
if abs(new_theta_rad - theta_rad) > 2^(-N)
    warning('The conversion is not correct!')
end

%% Block connections

% block BBR_L
sigma_L = zeros(1, m);
sigma_L(1) = 1 - 2*theta(1);
sigma_L(2:end) = 2*theta(2:m) - 1;

% block add_prediction
add_prediction = sum(theta(m+1:end).*p2(m:end)) + sum(sigma_L(1:m-1).*err) - 2^(-m) - (2*theta(1)-1)*2^(-5); % - (2*theta(1)-1)*2^(-m); % sigma(m) is not used
theta_H_corr = float2bin(add_prediction, N +1 -m, m-1); % it could be also negative

% verification of add_prediction
new_add_prediction = -theta_H_corr(1)*2^(-m+1) + sum(p2(m:end).*theta_H_corr(2:end));
if abs(new_add_prediction - add_prediction) > 2^(-N)
    disp(['The conversion for theta_H_corr is wrong! theta_rad = ', num2str(theta_rad)])
end

% verification of MAR
if abs(add_prediction) > 2^(-(m-1))
    disp(['Add prediction is too high! theta_rad = ', num2str(theta_rad)])
end

% verification of the input angle decomposition
app_theta = 0;
for i = 1:(m-1)
    for j = 1:n(i)
        app_theta = app_theta + sigma_L(i)*atan(2^(-s(j, i)));
    end
end
app_theta = app_theta + sigma_L(m)*atan(2^(-m)) + add_prediction;
if abs(theta_rad - app_theta) > 2^(-N)
    disp(['Theta too much different from its approximation! theta_rad - app_theta = ', num2str(theta_rad - app_theta),  ' theta_rad = ', num2str(theta_rad)])
end

% block BBR_H
sigma_H = zeros(1, N +1 -m +1);
sigma_H(1) = 1 - 2*theta_H_corr(1);
sigma_H(2:end) = 2*theta_H_corr(2:end) - 1;

% block R
for i = 1:(m - 1)
    for j = 1:n(i)
        app_tan = sigma_L(i)*2^(-s(j, i));
        x = x - app_tan*y;
        y = app_tan*x + y;
    end
end

% block S following the block R
app_tan = sigma_L(m)*2^(-m);
x = x - app_tan*y;
y = app_tan*x + y;

% block S
for i = m:(N+1)
    app_tan = sigma_H(i-m+1)*2^(-i);
    x = x - app_tan*y;
    y = app_tan*x + y;
end

end