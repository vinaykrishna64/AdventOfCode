clear all
clc

S = readlines("input.txt").split("");
S = S(:,2:end-1);
B = blizzard_locations(S);
S = str2double(S.replace(["#","^",">","v","<","."],string([5,1,1,1,1,0])));
sz = size(S);
S = snow_sim(S,B,2000,sz); %simulate blizzard
%% part 1
start = [1,2];
goal = [size(S,1),size(S,2)-1];
T1 = time2goal(S,start,goal);
part_1 = T1 
%% part 2
T2 = time2goal(S(:,:,T1+1:end),goal,start);
if ~T2
    disp("increase blizzard sims")
    T3 = 0;
else
    T3 = time2goal(S(:,:,T1+T2+1:end),start,goal);
end

part_2 = T1 + T2 + T3

%% functions
function [T] = time2goal(S,start,goal)
    T = 0;
    % manual noding until the path goes into the blizzard field
    t = 1; % t = 0
    NodeEdges = [];
    while true
        NodeEdges = [NodeEdges; [sub2ind(size(S),start(1),start(2),t) sub2ind(size(S),start(1),start(2),t+1)]];
        if start(1) == 1 %top start
            if S(sub2ind(size(S),start(1)+1,start(2),t+1)) == 0
                NodeEdges = [NodeEdges; [sub2ind(size(S),start(1),start(2),t) sub2ind(size(S),start(1)+1,start(2),t+1)]];
                break
            end
        else  % goal start
            if S(sub2ind(size(S),start(1)-1,start(2),t+1)) == 0
                NodeEdges = [NodeEdges; [sub2ind(size(S),start(1),start(2),t) sub2ind(size(S),start(1)-1,start(2),t+1)]];
                break
            end
        end
        t = t + 1;
    end
    Ts = t;
    % make nodes from each time to next time
    for t = Ts:size(S,3)-1
        for i = 1:size(S,1)
            for j = 1:size(S,2)
                if S(i,j,t) == 0
                    if numel(find(NodeEdges(:,2) == sub2ind(size(S),i,j,t))) %if node is connected to previous time
                        if S(i,j,t+1) == 0 %same place
                            NodeEdges = [NodeEdges; [sub2ind(size(S),i,j,t) sub2ind(size(S),i,j,t+1)]];
                        end
                        if i > 1
                            if S(i-1,j,t+1) == 0 % up
                                NodeEdges = [NodeEdges; [sub2ind(size(S),i,j,t) sub2ind(size(S),i-1,j,t+1)]];
                            end
                        end
                        if i < size(S,1)
                            if S(i+1,j,t+1) == 0 %down
                                NodeEdges = [NodeEdges; [sub2ind(size(S),i,j,t) sub2ind(size(S),i+1,j,t+1)]];
                            end
                        end
                        if S(i,j-1,t+1) == 0 %left
                            NodeEdges = [NodeEdges; [sub2ind(size(S),i,j,t) sub2ind(size(S),i,j-1,t+1)]];
                        end
                        if S(i,j+1,t+1) == 0 %right
                            NodeEdges = [NodeEdges; [sub2ind(size(S),i,j,t) sub2ind(size(S),i,j+1,t+1)]];
                        end
                    end
                end
            end
        end  
        if  numel(find(NodeEdges(:,2) == sub2ind(size(S),goal(1),goal(2),t+1)))
            T = t;
            return
        end
    end
end
function [S] = snow_sim(S,B,t,sz)
    for T = 1:t
        for i = 1:size(B,1)
            if B(i,3) == 1
                B(i,1:2) = B(i,1:2) + [-1,0];
                if B(i,1) == 1
                    B(i,1) = sz(1) - 1;
                end
            elseif B(i,3) == 3
                B(i,1:2) = B(i,1:2) + [1,0];
                if B(i,1) == sz(1)
                    B(i,1) = 2;
                end
            elseif B(i,3) == 4
                B(i,1:2) = B(i,1:2) + [0,-1];
                if B(i,2) == 1
                    B(i,2) = sz(2) - 1;
                end
            elseif B(i,3) == 2
                B(i,1:2) = B(i,1:2) + [0,1];
                if B(i,2) == sz(2)
                    B(i,2) = 2;
                end
            end 
        end
        Snew = zeros(sz); Snew(1,:) = 5; Snew(1,2) = 0; Snew(end,:) = 5;
        Snew(end,end-1) = 0; Snew(:,1) = 5; Snew(:,end) = 5;
        Snew(sub2ind(sz,B(:,1),B(:,2))) = 1;
        S(:,:,end+1) = Snew;
    end
end

function [B] = blizzard_locations(S)
    dirs = string(0:5);
    S = str2double(S.replace(["#","^",">","v","<","."],dirs));
    B = [];
    for i = 1:4
    I = find(S == i);
    [r,c] = ind2sub(size(S),I);
    B = [B ; [r,c,i*ones(size(r))]];
    end
end