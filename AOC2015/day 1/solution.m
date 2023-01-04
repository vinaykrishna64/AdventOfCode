clear all
clc

S = str2double(readlines("input.txt").replace(["(",")"],["1,","-1,"]).split(","));
part_1 = sum(S(1:end-1));

floors = cumsum(S(1:end-1));

part_2 = find(floors < 0 ,1)