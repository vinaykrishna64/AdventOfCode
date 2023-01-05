clear all
clc

S = str2vec(readlines("input.txt"));
S1 = S;
for i = 1:40
    S1 = convert(S1);
end
part_1 = numel(S1)

S2 = S;
for i = 1:50
    S2 = convert(S2);
end
part_2 = numel(S2)

function [S2] = convert(S)
    S2 = [];
    n = 1;
    track = S(1);
    for i = 2:numel(S)
        if S(i) == track
            n = n+1;
        else
            S2 = [S2 n track];
            n = 1;
            track = S(i);
        end
    end
    if n
        S2 = [S2 n track];
    end
end

function [sg] = str2vec(SG)
    sg = str2double(string(char(SG)'))';
end