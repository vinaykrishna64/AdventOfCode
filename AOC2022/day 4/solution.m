clear all
clc
S = readlines('input.txt');
sum(arrayfun(@(x) contain_full(str2double(x.split(',').split("-"))),S)) %part 1
sum(arrayfun(@(x) any_overlap(str2double(x.split(',').split("-"))),S)) %part 2

function [out] = contain_full(S)
    out = ((S(1,1) <= S(2,1)) & (S(1,2) >= S(2,2))) | ((S(2,1) <= S(1,1)) & (S(2,2) >= S(1,2)));
end

function [out] = any_overlap(S)
    if S(2,2) >= S(1,2)
        out =  S(1,2) >= S(2,1);
    else
        out =  S(2,2) >= S(1,1);
    end
end

