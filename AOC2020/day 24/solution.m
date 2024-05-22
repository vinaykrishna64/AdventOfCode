clear all
clc
filename = 'input.txt';
S = readlines(filename);
%% part 1
for idx = 1:numel(S)
    flipped_tile(idx) = sq_to_tile(line2seq(S(idx)));
end
[GC,GR] = groupcounts(flipped_tile');
fprintf('part 1 = %14d \n',sum(mod(GC,2)==1))

%% part 2
GR = GR(mod(GC,2)==1);
blacks = str2double(GR.split(","))+1000;
grid = zeros(2000);
grid(sub2ind(size(grid),blacks(:,1),blacks(:,2))) = 1;
for days = 1:100
    neighbours = conv2(grid,[0 1 1;1 0 1;1 1 0],"same");
    grid_next = grid;
    grid_next(grid == 0 & (neighbours == 2)) = 1;
    grid_next(grid == 1 & (neighbours == 0 | neighbours > 2)) = 0;
    grid = grid_next;
end
fprintf('part 2 = %14d \n',sum(grid,"all"))
%%
function [sq] = line2seq(L)
    L = char(L);
    sq = [];
    while numel(L)
        if L(1) == 's' | L(1) == 'n'
            sq = [sq; string(L(1:2))];
            L(1:2) = [];
        else
            sq = [sq; string(L(1))];
            L(1) = [];
        end
    end
end

function [tl] = sq_to_tile(sq)
    tl = [0;0];
    for idx = 1:numel(sq)
        if sq(idx) == "se" % se
            tl = tl + [0;1];
        elseif sq(idx) == "e" % e
            tl = tl + [1;0];
        elseif sq(idx) == "ne" % ne
            tl = tl + [1;-1];
        elseif sq(idx) == "nw" % nw
            tl = tl + [0;-1];
        elseif sq(idx) == "w" % w
            tl = tl + [-1;0];
        elseif sq(idx) == "sw" % sw
            tl = tl + [-1;1];
        end
    end
    tl = string(sprintf('%d,%d',tl));
end