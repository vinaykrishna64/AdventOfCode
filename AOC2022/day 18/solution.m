clear all
clc

S = str2double(readlines("input.txt").split(","));
N = size(S,1);
Sides = 6*ones(1,N);
dist = @(p1,p2) sum(abs(p1 -p2));
D = zeros(N,N);
for i = 1:N
    for j = 1:N
        D(i,j) = dist(S(i,:) , S(j,:));
    end
end

%% part 1
part_1 = sum(Sides) - sum(D == 1, "all")

%% part 2
[traps,water] = find_traps(S);
traparea = 0;
for i = 1:size(traps,1)
    D_t = sum(abs(traps(i,:) - S),2); % distance to traps
    traparea = traparea + sum(D_t == 1); % adjacent traps
end

part_2 =  part_1 - traparea 

figure("windowstate","maximized")
plot3(S(:,1),S(:,2),S(:,3),'ro')
hold on
plot3(traps(:,1),traps(:,2),traps(:,3),'bo')
plot3(water(:,1),water(:,2),water(:,3),'co')
view(-30,45)
legend({"Lava","Trapped air","water"})
exportgraphics(gcf,'pond.jpeg','Resolution',1200)
%% function
function [traps,water] = find_traps(S)
    iter = [min(S,[],"all"); max(S,[],"all")] + [-1;1];
    traps = [];
    water = [];
    for i = iter(1):iter(2)
        for j = iter(1):iter(2)
            for k = iter(1):iter(2)
                space = [i,j,k];
                if istrap(space,S,iter)
                    traps = [traps; space];
                elseif ~ismember(space,S,'rows')
                    water = [water; space];
                end
            end
        end
    end
    % quality check
    Q = ones(1,size(traps,1));
    for i = 1:size(traps,1)
        D_t = sum(abs(traps(i,:) - water),2); % distance to traps
        Q(i) =  sum(D_t == 1);
    end
    traps = traps(Q == 0,:);
    water = [water; traps(Q ~= 0, :)]; 
end
function [out] = istrap(space,S,iter)
    out = 0;
    if ~ismember(space,S,'rows')
        count = 0;
        Xp = iter(1):space(1); Xn = space(1):iter(2);
        Yp = iter(1):space(2); Yn = space(2):iter(2);
        Zp = iter(1):space(3); Zn = space(3):iter(2);
        % x axis
        pipe = ones(numel(Xp),3);
        pipe(:,1) = Xp; pipe(:,2) = space(2); pipe(:,3) = space(3);
        count = count + any(ismember(S,pipe,'rows'));
        pipe = ones(numel(Xn),3);
        pipe(:,1) = Xn; pipe(:,2) = space(2); pipe(:,3) = space(3);
        count = count + any(ismember(S,pipe,'rows'));
        % y axis
        pipe = ones(numel(Yp),3);
        pipe(:,1) = space(1); pipe(:,2) = Yp; pipe(:,3) = space(3);
        count = count + any(ismember(S,pipe,'rows'));
        pipe = ones(numel(Yn),3);
        pipe(:,1) = space(1); pipe(:,2) = Yn; pipe(:,3) = space(3);
        count = count + any(ismember(S,pipe,'rows'));
        % y axis
        pipe = ones(numel(Zp),3);
        pipe(:,1) = space(1); pipe(:,2) = space(2); pipe(:,3) = Zp;
        count = count + any(ismember(S,pipe,'rows'));
        pipe = ones(numel(Zn),3);
        pipe(:,1) = space(1); pipe(:,2) = space(2); pipe(:,3) = Zn;
        count = count + any(ismember(S,pipe,'rows'));
        if count == 6
            out = 1;
        end
    end
end