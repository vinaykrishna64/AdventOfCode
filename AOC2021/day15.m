clear all
clc
S = readlines("day15.txt").split('');
S = padarray(str2double(S(:,2:end-1)),[1 1],0,'both');
sz = size(S);

nodeEdge = [];

dirs = [-1 0; 1 0; 0 1; 0 -1];
Lind = @(i,j) i + (j-1)*sz(1);

for i = 2:(sz(1)-1)
    for j = 2:(sz(2)-1)
        for k = 1:4
            if  S(i+dirs(k,1),j+dirs(k,2)) >= 1
                nodeEdge = [nodeEdge; [Lind(i,j) Lind(i+dirs(k,1),j+dirs(k,2)), S(i+dirs(k,1),j+dirs(k,2))]];
            end
        end
    end
end
             
D = digraph(nodeEdge(:,1),nodeEdge(:,2),nodeEdge(:,3));

P = shortestpath(D,Lind(2,2),Lind(sz(1)-1,sz(2)-1));

part_1 = sum(S(P(2:end)))

%% build full map
S2 = S(2:end-1,2:end-1);
S3 = [];

for i = 1:5
    s = S2 + (i-1);
    s(s>9) = s(s>9) - 9;
    S3 = [S3 s];
end

S4 = [];
for j = 1:5
    s = S3 + (j-1);
    s(s>9) = s(s>9) - 9;
    S4 = [S4; s];
end


S4 = padarray(S4,[1 1],0,'both');

sz = size(S4);

nodeEdge = [];

dirs = [-1 0; 1 0; 0 1; 0 -1];
Lind = @(i,j) i + (j-1)*sz(1);

for i = 2:(sz(1)-1)
    for j = 2:(sz(2)-1)
        for k = 1:4
            if  S4(i+dirs(k,1),j+dirs(k,2)) >= 1
                nodeEdge = [nodeEdge; [Lind(i,j) Lind(i+dirs(k,1),j+dirs(k,2)), S4(i+dirs(k,1),j+dirs(k,2))]];
            end
        end
    end
end


D = digraph(nodeEdge(:,1),nodeEdge(:,2),nodeEdge(:,3));

P = shortestpath(D,Lind(2,2),Lind(sz(1)-1,sz(2)-1));

part_2 = sum(S4(P(2:end)))












































































