clear all
clc
S = readlines("day12.txt").split("-");
S2 = S.replace(["start","end"],["0","1"]);
caves = unique(S2);
small_caves = (lower(caves) == caves) & isnan(str2double(caves));
cave_ID = ["0";"1"];
np = 2; nn = -1;
for i = 3:numel(caves)
    if isnan(str2double(caves(i)))
        if small_caves(i)
            cave_ID(i) = string(nn);
            nn = nn - 1;
        else
           cave_ID(i) = string(np);
           np = np + 1; 
        end
    end
end
S2 = str2double(S2.replace(caves(2:end),cave_ID(2:end)));
C  = sort(str2double(cave_ID)); %available caves
conns = {};
for i = 1:numel(C)
    I = find(S2(:,1) == C(i));
    temp = S2(I+size(S2,1));
    I = find(S2(:,2) == C(i));
    conns{i} = [temp ;S2(I)];
end
M = containers.Map(C,conns);
%% part 1
paths = {0};
while true
    new_paths = {};
    for j = 1:numel(paths)
        p = paths{j};
        if p(end) ~= 1
            Conn = M(p(end));
            for i = 1:numel(Conn)
                if Conn(i) > 0
                    new_paths{end+1}  =  [p Conn(i)];
                elseif sum(p == Conn(i)) == 0
                    new_paths{end+1}  =  [p Conn(i)];
                end
            end
        else
             new_paths{end+1} = p;
        end
    end
    if numel(paths) == numel(new_paths)
        break
    end
    paths = new_paths;
end

part_1 = numel(paths)


%% part 2
paths = {0};
while true
    new_paths = {};
    for j = 1:numel(paths)
        p = paths{j};
        if p(end) ~= 1
            Conn = M(p(end));
            for i = 1:numel(Conn)
                if Conn(i) > 0
                    new_paths{end+1}  =  [p Conn(i)];
                elseif sum(p == Conn(i)) <= 1
                    if p2_check([p Conn(i)])
                        new_paths{end+1}  =  [p Conn(i)];
                    end
                end
            end
        else
             new_paths{end+1} = p;
        end
    end
    if numel(paths) == numel(new_paths)
        break
    end
    paths = new_paths;
end

part_2 = numel(paths)

function [out] = p2_check(p)
    if sum(p == 0) > 1
        out = 0;
        return
    end
    pu = unique(p);
    pu = pu(pu < 0);
    pc = arrayfun(@(x) sum(p == x),pu);
    if sum(pc > 1) > 1
        out = 0;
    else
        out = 1;
    end
end