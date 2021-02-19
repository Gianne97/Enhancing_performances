% Description
% -----------
% This Matlab script tests the paraCordic algorithm.

%% Preamble

clc

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

%% Input angles and evaluation
n_points = 101;
theta = linspace(-pi/4, pi/4, n_points);
cos_theta = zeros(1, n_points);
sin_theta = zeros(1, n_points);

for i = 1:n_points
    % Give a single angle expressed in radians in input
    [cos_theta(i), sin_theta(i)] = paraCordic_function(theta(i), N, m, err, s, n, K);
end

%% Graphs

fig = figure('units','normalized','outerposition',[0 0 1 1]); %Open the figure
plot(theta, cos_theta, theta, sin_theta, 'LineWidth', 2)
hold on
cos_M = cos(theta);
sin_M = sin(theta);
plot(theta, cos_M, theta, sin_M, 'LineWidth', 2)
legend('cos Para-CORDIC', 'sin Para-CORDIC', 'cos Matlab', 'sin Matlab', 'Location', 'best')
title(['Para-CORDIC ', num2str(N)])
axis([-0.8, 0.8, -1, 1])
hold off

errors = sum((cos_M - cos_theta).^2 + (sin_M - sin_theta).^2)/n_points