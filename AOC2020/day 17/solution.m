clear all
clc
filename = 'input.txt';
S = readlines(filename);
S = S.replace([".","#"],["0","1"]).split('');
S = str2double(S(:,2:end-1));
sz = size(S); 
%% part 1
grid = zeros(100,100,100);
grid(50+[1:sz(1)],50+[1:sz(2)],50) = S;
mask = ones(3,3,3);
mask(2,2,2) = 0;
for iter = 1:6
    neighbours = convn(grid,mask,'same');
    grid_new = grid;
    grid_new(grid == 1 & (neighbours < 2 | neighbours > 3)) = 0;
    grid_new(grid == 0 & (neighbours == 3)) = 1;
    grid = grid_new;
end

fprintf('part 1 = %14d \n',sum(grid,"all"))

%% part 2
grid = zeros(100,100,100,100);
grid(50+[1:sz(1)],50+[1:sz(2)],50,50) = S;
mask = ones(3,3,3,3);
mask(2,2,2,2) = 0;
for iter = 1:6
    neighbours = convn(grid,mask,'same');
    grid_new = grid;
    grid_new(grid == 1 & (neighbours < 2 | neighbours > 3)) = 0;
    grid_new(grid == 0 & (neighbours == 3)) = 1;
    grid = grid_new;
end
fprintf('part 2 = %14d \n',sum(grid,"all"))
