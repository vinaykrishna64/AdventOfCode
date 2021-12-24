clc
clear all
tic
fid = fopen('day9.txt');


%% part 1
n_lines = 100;
for i = 1:n_lines%lines
    line_1 = fgetl(fid);
    grid(i,:) = explode_rows(line_1);
end



risks = f_risk(grid);

ans1 = sum(risks,'all');

%% part 2
sz = size(grid);
[I,J] =  find(risks ~=0);
basins = [I,J];
Basin_no = zeros(sz);
for i = 1:length(basins)
    Basin_no(I(i),J(i)) = i;
end

for i = 1:sz(1)
    for j = 1:sz(2)
        if grid(i,j) ~= 9 & risks(i,j) == 0
           Basin_no(i,j) = map_to_low(i,j,grid,Basin_no,risks,sz);
        end
    end
end
for i = 1:length(basins)
    n = find(Basin_no(I(i),J(i)) == Basin_no);
    Basin_size(i) = length(n);
end
Basin_size =  sort( Basin_size,'descend');
ans2 = Basin_size(1) * Basin_size(2) *Basin_size(3) 
%% functions
function n = map_to_low(i,j,grid,Basin_no,risks,sz)
I = i; J = j;
count = 0;
while true
   if risks(I,J) == 0
        [I,J] = adjacent_low(I,J,grid,risks,sz);
   else
       n = Basin_no(I,J);
       break
   end
   count = count  + 1;
   if count > sum(sz) *5
       error('infinite loop')
   end
end
end



function [I,J] = adjacent_low(i,j,grid,risks,sz)
x = grid(i,j);
I = i;J = j;
    if i ~= 1  
        if x > grid(i-1,j)
            I = i-1;  
            return
        end
    end
    if  i ~= sz(1)
        if x > grid(i+1,j)
            I = i+1;   
            return
        end
    end
    if j ~= 1
        if x > grid(i,j-1)
            J = j-1; 
            return
        end
    end
    if j ~= sz(2)
        if x > grid(i,j+1)
            J = j+1;
            return
        end
    end
    
end
function risks = f_risk(grid)
sz = size(grid);
risks = zeros(sz);
%center 
    for i = 2:sz(1)-1
        for j = 2:sz(2)-1
            if min(grid(i-1:2:i+1,j)) > grid(i,j) & min(grid(i,j-1:2:j+1)) > grid(i,j)
                risks(i,j) = grid(i,j) + 1;
            end
        end
    end
%edges
    for j = 2:sz(2)-1
        if grid(2,j) > grid(1,j) & min(grid(1,j-1:2:j+1)) > grid(1,j)
            risks(1,j) = grid(1,j) + 1;
        end
    end
    for j = 2:sz(2)-1
        if grid(sz(1)-1,j) > grid(sz(1),j) & min(grid(sz(1),j-1:2:j+1)) > grid(sz(1),j)
            risks(sz(1),j) = grid(sz(1),j) + 1;
        end
    end
    for i = 2:sz(1)-1
        if min(grid(i-1:2:i+1,1)) > grid(i,1) & grid(i,2) > grid(i,1)
            risks(i,1) = grid(i,1) + 1;
        end
    end
    for i = 2:sz(1)-1
        if min(grid(i-1:2:i+1,sz(2))) > grid(i,sz(2)) & grid(i,sz(2)-1) > grid(i,sz(2))
            risks(i,sz(2)) = grid(i,sz(2)) + 1;
        end
    end
%corners
    if grid(1,1) < min([grid(1,2),grid(2,1)])
        risks(1,1) = grid(1,1) + 1;
    end
    if grid(1,sz(2)) < min([grid(1,sz(2)-1),grid(2,sz(2))])
        risks(1,sz(2)) = grid(1,sz(2)) + 1;
    end
    if grid(sz(1),1) < min([grid(sz(1),2),grid(sz(1)-1,1)])
        risks(sz(1),1) = grid(sz(1),1) + 1;
    end
    if grid(sz(1),sz(2)) < min([grid(sz(1),sz(2)-1),grid(sz(1)-1,sz(2))])
        risks(sz(1),sz(2)) = grid(sz(1),sz(2)) + 1;
    end
end
function row_exp = explode_rows(rows)
n = length(rows);
row_exp = zeros(1,n);
    for i = 1:n
        row_exp(i) = str2num(rows(i));
    end
end