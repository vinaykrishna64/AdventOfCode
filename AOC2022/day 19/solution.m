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
% cost ranges 
%       ore  clay   obs
% ore   1-4    0     0
% clay  1-4    0     0
% obs   1-4    1-20  0
% geo   1-4    0    1-20

for Bp = 1:numel(S)
    cost = costs{Bp};
    max_bots = [max(cost(:,1:3),[],1) 1000];
    paths = {};
    paths = {zeros(1,8)}; %[robots , minerals]
    paths{1}(1) = 1;
    for mins = 1:24
       new_paths = {};
       for i = 1:numel(paths)
           path = paths{i};
           % no builds at all
           new_paths{end+1} =  path + [zeros(1,4), path(1:4)];
           % all other possible builds
           for j = 1:4
               if all(cost(j,:) <= path(5:7)) & (path(j) < max_bots(j))
                   build = zeros(1,8); pay = zeros(1,8);
                   build(j) = 1;
                   pay(5:7) = cost(j,:);
                   new_paths{end+1} =  path+[zeros(1,4), path(1:4)]+build-pay;
               end
           end
       end
       paths = new_paths;
       clear new_paths
       % don't need resources idling 
       if true % remove idling ore paths & obsidian paths
           score = true(numel(paths),1);
           for k = 1:numel(paths)
               if paths{k}(5) > 8 | paths{k}(7) > 22 
                   score(k) = false;
               end
           end
           paths = paths(score);
           clear score
       end     
       if mins >= 18 % remove low performing geo paths at 18min 
           % seems perfect based on hand calcs based on ranges of costs
           score = 0;
           for k = 1:numel(paths)
               score(k) = paths{k}(8);
           end
           if max(score) > 2
               paths = paths(score >= max(score)-1);
           end
           if mins == 24
               Q(Bp) = max(score);
           end
           clear score
       end
    end 
    
end

part_1 = sum(Q .* [1:numel(S)])


save('solutionvals_p1.mat','Q','part_1')