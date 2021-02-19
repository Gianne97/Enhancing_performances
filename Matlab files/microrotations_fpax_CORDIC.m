% This script evaluates the micro rotations and the scaling factor that are necessary for the
% fpax-CORDIC. The word length and the values of parameter p assume only
% the values
% N: 16 --> p: 5, 8, 11, 14, 16
% N: 24 --> p: 8, 11, 14, 17, 20, 22, 24
% N: 32 --> p: 11, 14, 17, 20, 23, 26, 29, 32

N_cases = {'16', '24', '32'};
N16_p_cases = {'5', '8', '11', '14', '16'};
N24_p_cases = {'8', '11', '14', '17', '20', '22', '24'};
N32_p_cases = {'11', '14', '17', '20', '23', '26', '29', '32'};

res = {'N', 'p', 'n', 's', 'K'};

for i=1:length(N_cases)
    name = ['N', N_cases{i}, '_p_cases'];
    tmp = eval(name);
    for j = 1:length(tmp)
        N = str2double(N_cases{i});
        p = str2double(tmp{j});
        [m, n, s, e] = MAR(N, p);
        K = ScalingFactor_K(N, p, s);
        res_tmp = [N, p, {n'}, {s'}, K];
        res = [res; res_tmp];
    end
end