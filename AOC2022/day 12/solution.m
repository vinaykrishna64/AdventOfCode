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
path_2_size = Part_1;
path2 = {path_1};
for i = 1:numel(I)
    path2{i+1} = shortestpath(D,I(i),I_e);
    path_2_size(i+1) = numel(path2{i+1})-1;
end
J = find(path_2_size > 0);
[part_2 j] = min(path_2_size(path_2_size > 0));
part_2

%% path figure
figure('WindowState','maximized')
subplot(1,2,1)
contour(S(2:end-1,2:end-1),28)
[row,col]=  ind2sub(sz , path_1);
plot(col-1,row-1,'r-*')
hold on
[row,col]=  ind2sub(sz , path2{J(j)});
plot(col-1,row-1,'g-*')
heights = S(2:end-1,2:end-1);
heights(heights == 1) = 2;
heights(heights == 28) = 27;
heights = heights - 1;
contour(heights,28)
colorbar()
legend({'path 1','path 2','map'})
title('paths found')
subplot(1,2,2)
surf(heights)
view(-30,30)
title('3D representation of heights')
exportgraphics(gcf,'path-map.jpeg','Resolution',1200)