clc
clear all

data = readlines('day13.txt',"EmptyLineRule","skip");
n_end = 18;
fold_start = 19;
n_end = 916;
fold_start = 917;
N = data(1:n_end);
for i =1:n_end 
    points(i,1:2) = str2num(split(N(i)));
end
foldstr = data(fold_start:end);
for i = 1:length(foldstr)
    S = split(foldstr(i),'=');
    axis_str = char(S(1));
    if strcmp(axis_str(end) , 'x')
        folds(i,1:2) = [str2num(S(2)) , 0];
    else
        folds(i,1:2) = [str2num(S(2)) , 1];
    end
end

folds = folds + 1;
points = points + 1;
points = fliplr(points);
Grid_0 = zeros(max(points(:,1)),max(points(:,2)));
for i = 1:length(points)
    Grid_0(points(i,1),points(i,2)) = 1;
end

[new_grid] = fold_grid(Grid_0,folds(1,:));
%part 1
ans1 = sum(new_grid >= 1,'all')

for i = 2:length(folds)
   [new_grid] = fold_grid(new_grid,folds(i,:)); 
end

imshow(1-new_grid,'InitialMagnification',2000)
%% functions
function [newgrid] = fold_grid(grid,folds)
sz = size(grid);
F = folds(1)-1;
if folds(2) == 2
    newgrid = zeros(F,sz(2));
    newgrid = grid(1:F,:);
    newgrid = newgrid + flipud(grid(F+2:end,:));
    
else
    newgrid = zeros(sz(1),F);
    newgrid = grid(:,1:F);
    newgrid = newgrid + fliplr(grid(:,F+2:end));
end
end





