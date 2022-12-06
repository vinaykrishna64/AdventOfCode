clear all
clc
S = readlines('input.txt');
M = containers.Map(string(['a':'z']'),1:26);

A =  arrayfun(@(x) M(x),S.char());

A2 = A' == A;
I = find(arrayfun(@(x) sum(A2(x:x+3,x:x+3),'all') == 4,1:(numel(A)-3)) == 1);
ans = I(1)+3 %part_1


I = find(arrayfun(@(x) sum(A2(x:x+13,x:x+13),'all') == 14,1:(numel(A)-13)) == 1);
ans = I(1)+13 %part_2
