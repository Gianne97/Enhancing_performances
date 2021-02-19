function bin_out = float2bin(float_input, N, h)
%float2bin This function converts a float number whose magnitude is lower
%than 2^(-h) to a binary number with length 1 + N: 1 sign bit and N bit
%precision.

bin_out = zeros(1, N + 1);
if float_input >= 0
    bin_out(1) = 0;
    tmp = float_input;
else % the input angle is negative
    bin_out(1) = 1;
    tmp = 2^(-h) + float_input; % be aware of how the number are codified!!! Now tmp is positive and comprised between 0 and 1
end

for i = 2:(N+1)
    bin_out(i) = floor(tmp/(2^(-(i-1 +h))));
    tmp = tmp - bin_out(i)*2^(-(i-1 +h));
end