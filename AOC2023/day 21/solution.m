clear all
clc
filename            = 'input.txt';
S                   = readlines(filename);
S = S.split('');
S = str2double(S(:,2:end-1).replace(["#",".","S"],["0","1","2"]));

%part_1(S,64);
%% part 2 
% As you start repeating the symmetry is 2D makes the points
% increase in concentric squares
%finding quadratic realtion

[S_dist] = all_dist(S,11); % using graphs to get shortest distances
%%
% this is the most confident distance possible
row1 = S_dist(2,:);
f= arrayfun(@(x) sum(S_dist(:)==x),[1:min(row1(row1>0))]);

% odd cummulative
f(1:2:end) = cumsum(f(1:2:end));
% even cummulative
f(2:2:end) = cumsum(f(2:2:end)) + 1; %+1 for f(0)
fprintf("%14d\n",round(polyval(polyfit(65+131*[0:2],f(65+131*[0:2]),2),26501365))) %use int multiples of side length to find the polynomial
%% using graphs to get shortest distances
function [S_dist] = all_dist(S,exp_to)
    [startr,startc] = find(S == 2);
    S_repeater = S;
    S_repeater(startr,startc) = 1;
    S_exp = repmat(S_repeater,[exp_to exp_to]); % expand S use the RAM like you mean it
    S_exp(ceil(numel(S_exp )/2)) = 2; %set middle as start
    S_exp = padarray(S_exp,[1,1],0); %wall edges to stop leaving the area
    [startr,startc] = find(S_exp == 2);
    sz = size(S_exp);
    S_dist = zeros(sz);
    [startr,startc] = find(S_exp == 2);
    source = sub2ind(sz,startr,startc);
    G = mat2Graph(S_exp);
    d = distances(G,source);
    S_dist(1:numel(d)) =d;
    S_dist(isinf(S_dist)) =0;
end
function [ G] = mat2Graph(S)
   sz = size(S);
   edges = [];
   linear_ind = zeros(sz);
   linear_ind(:) = 1:numel(linear_ind);
   direcs = [0 1;1 0;0 -1;-1 0];
   for idx = 1:4
        shifted_linear_ind = circshift(linear_ind,direcs(idx,:));
        edges = [edges ; [linear_ind(S&circshift(S,direcs(idx,:))) shifted_linear_ind(S&circshift(S,direcs(idx,:)))]];
   end
   G = graph(edges(:,1),edges(:,2));
end

%% part 2 takes too long as states as arrays are inefficient data type for this

function [pos_str] = pos2str(pos)
pos_str = strjoin([string(pos(1));string(pos(2))],",");
end
%modulo index can be used to wrapped around the matrix to get the infinite repeating pattern
% but this increases comutations a lot
function [out] = check_wrapped_S(S,new_pos,sz)
    r = mod(new_pos(1),sz(1));
    c = mod(new_pos(2),sz(2));
    if r == 0
        r = sz(1);
    end
    if c == 0
        c = sz(2);
    end
    out = S(r,c);
end

function [] = part_1(S,remaining_steps)
    S = padarray(S,[1,1],0); %wall edges to stop leaving the area
    [startr,startc] = find(S == 2);
    % remaining_steps = 64;
    direcs = [0 1;1 0;0 -1;-1 0];
    % implementation of priority queue in matlab
    states = [startr,startc ,remaining_steps]; 
    sz = size(S);
    seen_locs = startr+(startc-1)*sz(1);
    final_locs = [];
    destination = sz;
    while numel(states)
        current_state = states(1,:);
        states(1,:) = [];
        if mod(current_state(3),2) == 0 % if even add to final answer
            % you can always reach even step locations as you can switch
            % with next step until loop runs out
            final_locs = [final_locs, current_state(1)+(current_state(2)-1)*sz(1)];
        end
        if current_state(3) == 0 %stop when steps expire
            continue
        end
        for idx = 1:4
            new_pos = current_state(1:2) + direcs(idx,:);
            new_pos_ind = new_pos(1)+(new_pos(2)-1)*sz(1);
            if S(new_pos_ind) & ~ismember(new_pos_ind,seen_locs) %not rock and not seen
                new_state = [new_pos,current_state(3)-1];
                seen_locs = [seen_locs,new_pos_ind];
                states = [states;new_state];
            end
        end
    end
    fprintf('part 1 = %14d \n',numel(final_locs)) 
end
