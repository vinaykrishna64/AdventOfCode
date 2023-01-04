clc
clear all

data = importdata('day2.txt');

dir = data.textdata;
dist = data.data;
pos = [0,0,0];

for i = 1:length(dir)
    if strcmp(dir(i),'up')
        pos(2) = pos(2) - dist(i);
    elseif strcmp(dir(i),'down')
        pos(2) = pos(2) + dist(i);
    elseif strcmp(dir(i),'forward')
        pos(1) = pos(1) + dist(i);
        pos(3) = pos(3) + pos(2)*dist(i);
    end
    if pos(2) < 0 
        disp(1)
    end
    
end
ans1 = pos(1) * pos(2)
ans2 = pos(1) * pos(3)
sprintf('%010d',ans2)