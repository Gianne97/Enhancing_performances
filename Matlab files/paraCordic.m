% Description
% -----------
% This .m file simulates the algorithm paraCordic
%

clear, clc

% word length: in our case it can be 16, 24, 32, 54, and 64
% The paraCordic doesn't contain other parameters
N = 16;

m = ceil((N - log2(3))/3);

% Loading of the constants (see CORDIC_algorithms_v4.pdf)
load('D:\Dropbox\Enhancing performances - SoC Design Laboratory\CORDIC algorithms\Constant values Para-CORDIC\errors.mat')
load('D:\Dropbox\Enhancing performances - SoC Design Laboratory\CORDIC algorithms\Constant values Para-CORDIC\coefficients_s_i^j.mat')
load('D:\Dropbox\Enhancing performances - SoC Design Laboratory\CORDIC algorithms\Constant values Para-CORDIC\number_of_coefficients_n(i).mat')
load('D:\Dropbox\Enhancing performances - SoC Design Laboratory\CORDIC algorithms\Constant values Para-CORDIC\scaling_factors_K.mat')

str = ['err = e', num2str(N), ';'];
eval(str)
str = ['s = s', num2str(N), ';'];
eval(str)
str = ['n = n', num2str(N), ';'];
eval(str)
str = ['K = K', num2str(N), ';'];
eval(str)

% Starting vector
x = K;
y = 0;

% powers of two
p2 = 2.^(-(1:N));

% input angle
theta_rad = 0;
theta = zeros(1, N+1);
while(abs(theta_rad)>pi/4)
    
    % random input angle: 1 sign bit and N precision bits
    theta = randi(2, 1, N+1)-1;
    
    % input angle in radians (its absolute value must be lower than pi/4)
    % if the first bit of theta is 1, then theta_rad is negative
    % if the first bit of theta is 0, then theta_rad is positive
    theta_rad = -theta(1) + sum(p2.*theta(2:end));
end

%% Block connections

% block BBR_L
sigma_L = zeros(1, m);
sigma_L(1) = 1 - 2*theta(1);
sigma_L(2:end) = 2*theta(2:m) - 1;

% block add_prediction
add_prediction = sum(theta(m+1:end).*p2(m:end)) + sum(sigma_L(1:m-1).*err) - 2^(-m); % sigma(m) is not used
theta_H_corr = float2bin(add_prediction, N +1 -m, m-1);

% block BBR_H
sigma_H = zeros(1, N +1 -m +1);
sigma_H(1) = 1- 2*theta_H_corr(1);
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

fprintf('The input angle in radians is: %.4f\n', theta_rad)
fprintf('The results of the paraCordic algorithm are: cos(theta) = %.4f, sin(theta) = %.4f\n', x, y)
fprintf('The results of the in built Matlab functions are: cos(theta) = %.4f, sin(theta) = %.4f\n', cos(theta_rad), sin(theta_rad))
fprintf('Verification of the trigonometric identity cos^2 + sin^2 = 1:\n paraCordic, %.4f;\n Matlab, %.4f\n', x^2+y^2, cos(theta_rad)^2+sin(theta_rad)^2)