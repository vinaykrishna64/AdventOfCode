clear all
clc

S = str2double(readlines("input.txt").replace(["turn on ","turn off ","toggle "," through "]...
    ,["1,","2,","3,",","]).split(","));

%% part 1

grid = zeros(1000);
for i = 1:size(S,1)
    type = S(i,1);
    Tgt = S(i,2:end)+1;
    r = Tgt(1):Tgt(3); c = Tgt(2):Tgt(4);
    if type == 1
        grid(r,c) = 1;
    elseif type == 2
        grid(r,c) = 0;
    elseif type == 3
        grid(r,c) = 1 - grid(r,c);
    end
end

part_1 = sum(grid,"all")


%% part 2

grid = zeros(1000);
for i = 1:size(S,1)
    type = S(i,1);
    Tgt = S(i,2:end)+1;
    r = Tgt(1):Tgt(3); c = Tgt(2):Tgt(4);
    if type == 1
        grid(r,c) = grid(r,c) + 1;
    elseif type == 2
        grid(r,c) = grid(r,c) - 1;
        grid(grid < 0) = 0;
    elseif type == 3
        grid(r,c) = grid(r,c) + 2;
    end
end

part_2 = sum(grid,"all")