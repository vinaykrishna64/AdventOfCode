clear all
clc
filename = 'input.txt';
S = str2double(readlines(filename));
S = sort(S);
device = S(end) + 3;

charge = [0 ;S; device];
cd = diff(charge);
p1 = sum(cd == 1) * sum(cd == 3);

disp(sprintf('part_1 = %d',p1))
%%
I = find(cd == 3)+1;
place = 1;
ways = 1;
if I(1) ~=1
    for i = 1:numel(I)-1
        goal = I(i+1);
        ways = ways * search_arrange(charge,0,place,goal);
        place = goal;
    end
else
    for i = 2:numel(I)-1
        goal = I(i+1);
        ways = ways * search_arrange(charge,0,place,goal);
        place = goal;
    end
end
fprintf('part_2 = %15d \n',ways)
%%

function [ways] = search_arrange(charge,ways,place,goal)
    if place == goal
        ways = ways + 1;
        return 
    end
    for i = (place+1):numel(charge)
        if charge(i) - charge(place) <= 3
            ways = search_arrange(charge,ways,i,goal);
        end
    end
end