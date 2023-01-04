clear all
clc

S = str2double(string(char(readlines("input.txt"))').replace([">","<","^","v"],["1,0","-1,0","0,1","0,-1"]).split(","));

S = [[0,0];S];
%% part 1
P = cumsum(S,1);

[C,ia,ic] = unique(P,'rows');
part_1 = size(C,1)

%% part 2
P_s = cumsum([S(1,:); S(2:2:end,:)],1);
P_e = cumsum([S(1,:); S(3:2:end,:)],1);

[C,ia,ic] = unique([P_s;P_e],'rows');
part_2 = size(C,1)