clc
clear all
tic
fid = fopen('day11.txt');


%% part 1
n_lines = 10;
for i = 1:n_lines%lines
    line_1 = fgetl(fid);
    grid(i,:) = explode_rows(line_1);
end




sz = size(grid);
i = 1;
while true
    [grid,flashes(i)] = turn_n(grid);
    
    if flashes(i) == sz(1) * sz(2)
        % part 2
        disp('first synchronous flash at turn')
        disp(i)
        break
    end
    i = i+1;
end
%part 1
disp('total flahses')
disp(sum(flashes(1:100)))
%% functions

function [grid,flashes] = turn_n(grid)
sz = size(grid);
flashed = zeros(sz);
% energy increase
grid = grid + 1;
    while true
        % +9 octos
        [I,J] = find(grid > 9);
        [I1,J1] = find(flashed == 1);
        if length(I1) == length(I) 
            I2 = find(flashed == 1);
            grid(I2) = 0;
            flashes = sum(flashed,'all');
            break
        end
        if length(I)
            %flashes
            for i = 1:length(I)
                if flashed(I(i),J(i)) == 0 %not flashed
                    %record flash
                    flashed(I(i),J(i)) = 1;
                    %flash energy
                    if I(i) == 1 & J(i) == 1%corner 1
                        grid(1:2,1:2) = grid(1:2,1:2) + 1;
                    elseif I(i) == 1 & J(i) == sz(2)%corner 2 
                        grid(1:2,sz(2)-1:sz(2)) = grid(1:2,sz(2)-1:sz(2)) + 1;
                    elseif I(i) == sz(1) & J(i) == 1%corner 3 
                        grid(sz(1)-1:sz(1),1:2) = grid(sz(1)-1:sz(1),1:2) + 1;
                    elseif I(i) == sz(1) & J(i) == sz(2)%corner 4  
                        grid(sz(1)-1:sz(1),sz(2)-1:sz(2)) = grid(sz(1)-1:sz(1),sz(2)-1:sz(2)) + 1;
                    elseif I(i) == 1 & ( J(i) ~= 1 | J(i) ~= sz(2)) %edge top
                        grid(I(i):I(i)+1,J(i)-1:J(i)+1) = grid(I(i):I(i)+1,J(i)-1:J(i)+1) + 1;
                    elseif I(i) == sz(1) & ( J(i) ~= 1 | J(i) ~= sz(2)) %edge bottom
                        grid(I(i)-1:I(i),J(i)-1:J(i)+1) = grid(I(i)-1:I(i),J(i)-1:J(i)+1) + 1;
                    elseif J(i) == 1 & ( I(i) ~= 1 | I(i) ~= sz(1)) %edge left
                        grid(I(i)-1:I(i)+1,J(i):J(i)+1) = grid(I(i)-1:I(i)+1,J(i):J(i)+1) + 1;
                    elseif J(i) == sz(2) & ( I(i) ~= 1 | I(i) ~= sz(1)) %edge right
                        grid(I(i)-1:I(i)+1,J(i)-1:J(i)) = grid(I(i)-1:I(i)+1,J(i)-1:J(i)) + 1;
                    else %central matrix
                        grid(I(i)-1:I(i)+1,J(i)-1:J(i)+1) = grid(I(i)-1:I(i)+1,J(i)-1:J(i)+1) + 1;
                    end
                end
            end
        end
    end
end




function row_exp = explode_rows(rows)
n = length(rows);
row_exp = zeros(1,n);
    for i = 1:n
        row_exp(i) = str2num(rows(i));
    end
end