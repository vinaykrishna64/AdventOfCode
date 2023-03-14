clear all
clc
filename = 'input.txt';
S = readlines(filename);
T = str2double(S(1));
BusID = str2double(S(2).replace('x','0').split(','));
Bus_valid = BusID(BusID>0);
T_wait = arrayfun(@(x) mod(x - mod(T,x),x), Bus_valid);
[m,I] = min(T_wait);

disp(sprintf('part_1 = %d',m*Bus_valid(I)))

for i = 1:numel(Bus_valid)
    Bus_T(i) = find(Bus_valid(i) == BusID)-1;
end
b = mod(Bus_valid - mod(Bus_T',Bus_valid),Bus_valid); % b_i
p2 = crt(b',Bus_valid');
disp(sprintf('part_2 = %d',p2))


