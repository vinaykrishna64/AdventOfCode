clear all
clc

S = readlines("input.txt");
P = str2double(regexp(S,'(\d+)','match'));

% index map
f = @(c) c*(c+1)/2; %fist row is sum of c numbers
% columns are addition of next number starting from c
f1 = @(r,c) (r-1)*c;
f2 = @(r,c) (r-1)*(r-2)/2;
F = @(r,c) f(c) + f1(r,c)*(f1(r,c) > 0) + f2(r,c)*(f2(r,c) > 0); 

% next number calculation
F_2 = @(x) mod(x*252533,33554393);


x_1 = 20151125;

for i = 2:F(P(1),P(2)) %calculate next numbr until index is reached
    x_1 = F_2(x_1);
end


fprintf('part_1 = %14d \n',x_1)

