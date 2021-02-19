% Description
% -----------
% This script simulates the working of the block Add_prediction in the
% para-CORDIC algorithm.

clear
clc

% the following command line loads the errors table (see CORDIC_algorithms_v4.pdf)
load('D:\Dropbox\Enhancing performances - SoC Design Laboratory\CORDIC algorithms\Constant values Para-CORDIC\errors.mat')

N = 16; % word length. In our case it can be 16, 24, 32, 54, and 64.

p2 = 2.^(-(1:N)); % powers of two

theta_rad = 1;
while(abs(theta_rad)>pi/4)
    theta = randi(2, 1, N+1)-1; % random input angle: 1 sign bit and word length N
    theta_rad = (theta(1)*2-1)*sum(theta(2:end).*p2); % input angle in radians (it must be lower than pi/4)
end

m = ceil((N - log2(3))/3);

% block BBR_L
sigma_L = zeros(1, m);
sigma_L(1) = 1 - 2*theta(1);
sigma_L(2:end) = 2*theta(2:m) - 1;

% loading of the useful error coefficients
str = ['err = e', num2str(N), ';'];
eval(str)

% simulation of the block add_prediction
add_prediction = sum(theta(m+1:end).*p2(m:end)) + sum(sigma_L(1:m-1).*err) - 2^(-m); % sigma(m) is not used