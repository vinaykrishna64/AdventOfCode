clear all
clc

S = readlines("input.txt").erase(["can fly ",...
    " km/s for"," seconds, but then must rest for"," seconds."]).split(" ");
s = str2double(S(:,2:end));
%% part 1
T = 2503;
t = s(:,2) + s(:,3);
D = s(:,1) .* s(:,2) .* (floor(T./t) + min(mod(T,t)./s(:,2),1));


part_1 = max(D)


%% part 2
scores = zeros(1,size(S,1));
for T = 1:2503
    t = s(:,2) + s(:,3);
    D = s(:,1) .* s(:,2) .* (floor(T./t) + min(mod(T,t)./s(:,2),1));
    [~,idx] = max(D);
    scores(idx) = scores(idx) + 1;
end


part_2 = max(scores)