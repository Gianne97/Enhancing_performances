function [x, y] = fpaxCordic(theta_rad, N, m, s, n, K)
%fpaxCordic_function This function simulates the fpaxCORDIC algorithm
%   This function returns the cosine x and the sine y of the input angle
%   theta_rad. Moreover, it requires:
%   - N, number of precision bits
%   - m, ceil((N - log2(3))/3)
%   - p, error tolerant parameter
%   - s, matrix containing the tangent values for the microrotations
%   - n, vector containing the number of microrotations
%   - K, scaling factor

% Starting vector
x = K;  
y = 0;

% powers of two
p2 = 2.^(-(1:N));

theta = float2bin(theta_rad, N, 0);

%% Block connections

% block BBR_L
sigma_L = zeros(1, m);
sigma_L(1) = 1 - 2*theta(1);
sigma_L(2:end) = 2*theta(2:m) - 1;

% theta_L_rad = -theta(1) + sum(theta(2:m).*p2(1:(m-1)));
%
% theta_H = [zeros(1, m), theta(m+1:end)];
% theta_H_rad = -theta_H(1) + sum(theta_H(2:end).*p2);
%
% % -2^(-m)
% corr_factor = [ones(1, m+1), zeros(1, N-m)];
% corr_factor_rad = -corr_factor(1) + sum(corr_factor(2:end).*p2);

% % sum between corr_factor and theta_H
% if theta_H(m+1) == 1
%     theta_H_corr = [zeros(1, m+1), theta_H(m+2:N+1)];
% else
%     theta_H_corr = [ones(1, m+1), theta_H(m+2:N+1)];
% end
%
% theta_H_corr_rad = theta_H_rad - 2^(-m); % it could be also negative
% theta_H_corr = float2bin(theta_H_corr_rad - 2^(-m), N +1 -m, m-1); % it could be also negative
%
% theta_H_corr_rad1 = theta_H_rad - 2^(-m);
%
% tmp = abs(theta_H_corr_rad1);
%
% theta_H_corr = zeros(1, N-m+2);
% for i = 2:(N-m+2)
%     theta_H_corr(i) = floor(tmp/(2^(-(i-2 +m))));
%     tmp = tmp - theta_H_corr(i)*2^(-(i-2 +m));
% end
%
% if theta(1) == 1
%     theta_H_corr(1) = 1;
%     theta_H_corr(2:end) = not(theta_H_corr(2:end));
% end

% theta_H_corr = float2bin(theta_H_corr_rad1, N +1 -m, m-1);
% theta_H_corr_rad2 = -theta_H_corr(1)*2^(-m+1) + sum(theta_H_corr(2:end).*p2(m:end));

% theta_H_corr = [0, theta_H]; % theta_H is always positive
% corr_factor = [1, 1, zeros(1, N-m)]; % -2^(-m), two's complement, length: N-m+2
% corr_factor_rad = -corr_factor(1)*2^(-m+1) + sum(corr_factor(2:end).*p2(m:N)); % two's complement
% % binary sum between theta_H_corr and corr_factor
% theta_H_corr(1) = xor(and(theta_H_corr(2), corr_factor(2)), corr_factor(1));
% theta_H_corr(2) = xor(theta_H_corr(2), corr_factor(2));
% theta_H_corr_rad1 = theta_H_rad - 2^(-m);
% theta_H_corr_rad2 = -theta_H_corr(1)*2^(-m+1) + sum(theta_H_corr(2:end).*p2(m:end));
% theta_H_corr_rad = sum(theta((m+1):end).*p2(m:end));
% theta_H_corr = float2bin(theta_H_corr_rad - 2^(-m), N +1 -m, m-1); % it could be also negative

% add_prediction = sum(theta(m+1:end).*p2(m:end)) - 2^(-m); % - (2*theta(1)-1)*2^(-m); % sigma(m) is not used
% theta_H_corr = float2bin(add_prediction, N +1 -m, m-1); % Length: N-m+2
% theta_H_corr_rad = -theta_H_corr(1)*2^(-m+1) + sum(theta_H_corr(2:end).*p2(m:end));

add_prediction = sum(theta(m+1:end).*p2(m:end)) - 2^(-m) - (2*theta(1)-1)*2^(-5);
theta_H_corr = float2bin(add_prediction, N +1 -m, m-1); % Length: N-m+2

% if add_prediction < 0
%     theta_H_corr(1) = 1;
% end

theta_H_corr_rad = -theta_H_corr(1)*2^(-m+1) + sum(theta_H_corr(2:end).*p2(m:end));

% block BBR_H
sigma_H = zeros(1, N +1 -m +1);
sigma_H(1) = 1 - 2*theta_H_corr(1);
sigma_H(2:end) = 2*theta_H_corr(2:end) - 1;

theta_H_corr_rad2 = sum(sigma_H.*2.^(-(m:(N+1)))) - 2^(-N-1);

% block R: m-1 macrorotations
for i = 1:(m - 1)
    for j = 1:n(i)
        app_tan = sigma_L(i)*2^(-s(j, i));
        x = x - app_tan*y;
        y = app_tan*x + y;
    end
end

% block S following the block R: 1 microrotation
app_tan = sigma_L(m)*2^(-m);
x = x - app_tan*y;
y = app_tan*x + y;

% block S: N - m + 2 microrotations
for i = m:(N+1)
    app_tan = sigma_H(i-m+1)*2^(-i);
    x = x - app_tan*y;
    y = app_tan*x + y;
end

end

