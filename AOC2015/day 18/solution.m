clear all
clc

L = readlines("input.txt").replace([".","#"],["0","1"]).split('');
%% part_1
L1 = str2double(L(:,2:end-1));
for i = 1:100
    N = conv2(L1, ones(3), 'same') - L1;
    L1(L1 == 0 & N == 3) = 1; L1(L1 == 1 & (N < 2 | N > 3)) = 0;
end

part_1 = sum(L1,"all")

%% part_2

L2 = str2double(L(:,2:end-1));
I = sub2ind([100 100],[1 1 100 100],[1 100 1 100]);
L2(I) = 1;
for i = 1:100
    N = conv2(L2, ones(3), 'same') - L2;
    L2(L2 == 0 & N == 3) = 1; L2(L2 == 1 & (N < 2 | N > 3)) = 0;
    L2(I) = 1;
end

part_2 = sum(L2,"all")
