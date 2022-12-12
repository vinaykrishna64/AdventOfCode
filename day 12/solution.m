clear all
clc
S = readlines("input.txt").split("");
S = str2double(S(:,2:end-1).replace(string(['a':'z' 'S' 'E']'),string([2:27 1 28]')));
S = padarray(S,[1 1],99,'both');
I_s = find(S == 1);
I_e = find(S == 28);
sz = size(S);
nodeEdge = [];

dirs = [-1 0; 1 0; 0 1; 0 -1];
Lind = @(i,j) i + (j-1)*sz(1);

for i = 2:(sz(1)-1)
    for j = 2:(sz(2)-1)
        for k = 1:4
            if  (S(i+dirs(k,1),j+dirs(k,2)) - S(i,j)) <= 1
                nodeEdge = [nodeEdge; [Lind(i,j) Lind(i+dirs(k,1),j+dirs(k,2))]];
            end
        end
    end
end
             
D = digraph(nodeEdge(:,1),nodeEdge(:,2));
figure 
subplot(2,2,1)
plot(D)
title('Graph of the elevation map')
subplot(2,2,2)
plot(D)
title('Graph zoomed to available connections') %done manually look at saved image
subplot(2,2,3:4)
plot(D)
title('Graph zoomed look at connections') %done manually look at saved image
% exportgraphics(gcf,'node-map.jpeg','Resolution',1200)
path_1 = shortestpath(D,I_s,I_e);
Part_1 = numel(path_1)-1


%% part 2
I =  find(S == 2);
path_2 = Part_1;
for i = 1:numel(I)
    path_2(i+1) = numel(shortestpath(D,I(i),I_e))-1;
end
part_2 = min(path_2(path_2 > 0))