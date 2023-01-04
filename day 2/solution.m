clear all
clc

S = str2double(readlines("input.txt").split("x"));

area = S.*circshift(S,-1,2);
area = sum(2*area,2) + min(area,[],2);

part_1 = sum(area)

S = sort(S,2);
V = prod(S,2);
R = V + 2*sum(S(:,1:2),2);

part_2 = sum(R)
