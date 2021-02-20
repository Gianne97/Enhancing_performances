% Description
% -----------
% This Matlab script tests the fpaxCordic algorithm.

%% Preamble

clc

N = 16; % possible values: 16, 24, 32
p = 5;  % possible values: if N=16, 5, 8, 11, 14, 16; if N=24, 8, 11, 14, 17, 20, 22, 24; if N=32, 11, 14, 17, 20, 23, 26, 29, 32
m = ceil((N - log2(3))/3);

[m, n, s, e] = MAR(N, p);
K = ScalingFactor_K(N, p, s);

% Loading of the constants (see CORDIC_algorithms_v4.pdf)
% load('D:\Dropbox\Enhancing performances - SoC Design Laboratory\CORDIC algorithms\Constant values fpax-CORDIC\Microrotations_fpax_CORDIC.mat')
% values = cell2table(fpax_CORDIC(2:end, :), 'VariableNames', fpax_CORDIC(1, :));
%
% ind = and(values.N == N, values.p == p);
%
% n = values.n{ind}';
% s = values.s{ind}';
% K = values.K(ind);

%% Input angles and evaluation
n_points = 101;
theta = linspace(-pi/4, pi/4, n_points);
cos_theta = zeros(1, n_points);
sin_theta = zeros(1, n_points);

for i = 1:n_points
    % Give a single angle expressed in radians in input
    [cos_theta(i), sin_theta(i)] = fpaxCordic(theta(i), N, m, s, n, K);
end

%% Graphs

fig = figure('units','normalized','outerposition',[0 0 1 1]); %Open the figure
plot(theta, cos_theta, theta, sin_theta, 'LineWidth', 2)
hold on
cos_M = cos(theta);
sin_M = sin(theta);
plot(theta, cos_M, theta, sin_M, 'LineWidth', 2)
legend('cos fpax-CORDIC', 'sin fpax-CORDIC', 'cos Matlab', 'sin Matlab', 'Location', 'best')
title(['fpax-CORDIC ', num2str(N), ' error tolerant parameter ', num2str(p)])
axis([-0.8, 0.8, -1, 1])
hold off

errors = sum((cos_M - cos_theta).^2 + (sin_M - sin_theta).^2)/n_points