clear all
clc
S = readlines('input.txt');
M = containers.Map(string(['a':'z']'),1:26);

A =  arrayfun(@(x) M(x),S.char());
n = numel(A);

A2 = A' == A;
tic 
I = find(arrayfun(@(x) sum(A2(x:x+3,x:x+3),'all') == 4,1:(numel(A)-3)) == 1);
ans = I(1)+3 %part_1
toc
tic
I = find(arrayfun(@(x) sum(A2(x:x+13,x:x+13),'all') == 14,1:(numel(A)-13)) == 1);
ans = I(1)+13 %part_2
toc

%% different way of programming same logic and much faster
tic
n = 4;
S = 0;
for i = 1:n
    D = diag(A2,i-1);
    S = S + D(1:end-(n-(i-1)));
end
I = strfind(S',ones(1,4));
I(1) + n - 1
toc

tic
n = 14;
S = 0;
for i = 1:n
    D = diag(A2,i-1);
    S = S + D(1:end-(n-(i-1)));
end
I = strfind(S',ones(1,4));
I(1) + n - 1
toc