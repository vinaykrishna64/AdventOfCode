clear all
clc

S = readlines("input.txt").erase(["to ","= "]).split(" ");
S = [S ; [S(:,2),S(:,1),S(:,3)]];
Loc = unique([S(:,1);S(:,2)]);
M = containers.Map(Loc,1:numel(Loc));
Neibs = {};
for i = 1:numel(Loc)
    Neibs{i} = S(find(S(:,1) == Loc(i)),2);
    costs{i} = str2double(S(find(S(:,1) == Loc(i)),3));
end
%% part 1
for i = 1:numel(Loc)
    visits = ones(size(Loc));
    L = Loc(i);
    visits(M(L)) = 0;
    cost = 0;
    mincost = 1000;
    MINC(i) = min_cost(visits,L,Loc,M,Neibs,costs,cost,mincost);
end
part_1 = min(MINC)
%% part 2
for i = 1:numel(Loc)
    visits = ones(size(Loc));
    L = Loc(i);
    visits(M(L)) = 0;
    cost = 0;
    maxcost = 0;
    MAXC(i) = max_cost(visits,L,Loc,M,Neibs,costs,cost,maxcost);
end
part_2 = max(MAXC)
%% functions
function [mincost] = min_cost(visits,L,Loc,M,Neibs,costs,cost,mincost)
    visits(M(L)) = 0;
    if all(visits == 0) & cost < mincost
        mincost = cost;
        return
    end
    N = Neibs{M(L)};
    C = costs{M(L)};
    for i = 1:numel(N)
        if visits(M(N(i)))
            mincost = min_cost(visits,N(i),Loc,M,Neibs,costs,cost + C(i),mincost);
        end
    end
    return
end

function [maxcost] = max_cost(visits,L,Loc,M,Neibs,costs,cost,maxcost)
    visits(M(L)) = 0;
    if all(visits == 0) & cost > maxcost
        maxcost = cost;
        return
    end
    N = Neibs{M(L)};
    C = costs{M(L)};
    for i = 1:numel(N)
        if visits(M(N(i)))
            maxcost = max_cost(visits,N(i),Loc,M,Neibs,costs,cost + C(i),maxcost);
        end
    end
    return
end