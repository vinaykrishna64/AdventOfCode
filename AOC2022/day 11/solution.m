%% parse inputs
clear all
clc
S = readlines("input.txt");

n_monekys = (numel(S)+1)/7;
items = [];
pos = [];
dest_check = zeros(n_monekys,3);
for i = 1:n_monekys 
    item_str = S((i-1)*7 + 2).split(":");
    if contains(item_str(2),",")
        items = [items str2double(item_str(2).split(","))'];
        pos = [pos i*ones(1,numel(str2double(item_str(2).split(","))'))];
    else
        items = [items str2double(item_str(2))'];
        pos = [pos i];
    end
    op_str = S((i-1)*7 + 3).split("= ");
    ops(i) = op_str(2); %the operation
    % moneky detinations
    d_str = S((i-1)*7 + 4).split(" ");
    dest_check (i,1) = str2double(d_str(end));
    d_str = S((i-1)*7 + 5).split(" ");
    dest_check (i,2) = str2double(d_str(end))+1;
    d_str = S((i-1)*7 + 6).split(" ");
    dest_check (i,3) = str2double(d_str(end))+1;
end

n_items = numel(items);
items_2 = items; %copy fo part2
pos_2 = pos;
%% part 1
n_rounds = 20;

for n = 1:n_rounds
    for i = 1:n_monekys
        vist_count(n,i) = sum(pos == i);
        if sum(pos == i)
            for j = 1:n_items
                if pos(j) == i
                    % operation test
                    items(j) = floor(eval(ops(i).replace("old",num2str(items(j))))/3);
                    % test
                    if mod(items(j),dest_check(i,1)) ~= 0
                        pos(j) = dest_check(i,3);
                    else
                        pos(j) = dest_check(i,2);
                    end
                end
            end
        end
    end
end
vists = sum(vist_count,1);
part_1 = prod(maxk(vists,2))

%% part 2

n_rounds = 10000;
mod_num = prod(dest_check(:,1)); % product of all divisors being checked
                                 % control input by cycling through mod_num
for n = 1:n_rounds
    for i = 1:n_monekys
        vist_count(n,i) = sum(pos_2 == i);
        if sum(pos_2 == i)
            for j = 1:n_items
                if pos_2(j) == i
                    % operation test
                    items_2(j) = eval(ops(i).replace("old",num2str(items_2(j))));
                    items_2(j) = mod(items_2(j), mod_num);
                    % test
                    if mod(items_2(j),dest_check(i,1)) ~= 0
                        pos_2(j) = dest_check(i,3);
                    else
                        pos_2(j) = dest_check(i,2);
                    end
                end
            end
        end
    end
end

               

vists = sum(vist_count,1);
part_2 = prod(maxk(vists,2));
disp(sprintf("part_2 =\n %14d ",part_2))

