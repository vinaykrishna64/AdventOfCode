clear all
clc

S = readlines("input.txt");
costs = {};
for i = 1:numel(S)
    cost = zeros(4,3);
    s = S(i).split(" ");
    cost(1,1) = str2double(s(7));
    cost(2,1) = str2double(s(13));
    cost(3,1:2) = [str2double(s(19)) str2double(s(22))];
    cost(4,[1,3]) = [str2double(s(28)) str2double(s(31))];
    costs{i} = cost;
end 

%% part 1
for i = 1:numel(S)
    cost = costs{i};
    max_spend = [max(cost,[],1) 100];
    robots = [1 0 0 0];
    store = zeros(1,4);
    mins = 24;
    Mg(i) = Geode_DFS(cost,max_spend,mins,robots,store,0);
end

part_1 = sum(Mg .* [1:numel(S)])

%% part 2
for i = 1:3
    cost = costs{i};
    max_spend = [max(cost,[],1) 100];
    robots = [1 0 0 0];
    store = zeros(1,4);
    mins = 32;
    Mg2(i) = Geode_DFS(cost,max_spend,mins,robots,store,0);
end

part_1 = prod(Mg2)
%% functions
function max_geode = Geode_DFS(cost,max_spend,mins,robots,store,max_record)
    max_geode = store(4);
    if mins == 0 
        return
    end
    for i = 1:4
        if robots(i) < max_spend(i) % if max reach don't build
            wait = 0;
            flg = 1;
            for j = 1:3
                if ~robots(j) % check if robots are available to make resources
                    flg = 0;
                    continue
                end
                wait = max(wait,ceil((cost(i,j) - store(j))/ robots(j))); % time required to build one
            end
            wait = wait + 1;
            if mins - wait <= 0 % can it build in the ramining time?
                max_geode = max(max_geode, store(4) + robots(4)*mins);
                continue
            end
            robots_ = robots;
            store_ = store + robots*wait; % predict resources till wait time
            store_ = store_ - [cost(i,:) 0]; % remove cost from predicted storage
            if any(store_ <0)
                return
            end
            robots_(i) = robots_(i) + 1; %mkae robots after wait time
            max_geode = max(max_geode,Geode_DFS(cost,max_spend,mins - wait,robots_,store_,max_geode));
        end
    end
end
