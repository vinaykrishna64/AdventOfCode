clear all
clc

S = readlines("input.txt");

cave = zeros(200,1000);

%% fill cave
low = 10;
for i = 1:numel(S)
    s = fliplr(str2double(S(i).split(" -> ").split(",")));
    s(:,1) = s(:,1)+1; %account for 0 layer
    if max(s(:,1)) >low
        low = max(s(:,1));
    end
    for j = 1:size(s,1)-1
        I = sort(s(j:j+1,:),1);
        cave(I(1,1):I(2,1),I(1,2):I(2,2)) = 1;
    end
end
tic 
[cave1,count1] = sand_sim(cave,[1,500],low+1,1);
toc
part_1 = count1 - 1;
%% part 2;
cave1(low+2,:) = 1;
tic
[cave2,count2] = sand_sim(cave1,[1,500],low+1,2);
toc
part_2 = part_1 + count2;
%% plots
figure('WindowState','maximized')
subplot(2,1,1)
imagesc(cave1)
title("first part")
subplot(2,1,2)
imagesc(cave2)
title("second part")
exportgraphics(gcf,'cave_filled.jpeg','Resolution',1200)
%% sand simulation

function [cave,count] = sand_sim(cave,start,low,flg)
    old = start;
    cave(old(1),old(2)) = 2;
    count = 1;
    if flg == 1 %part 1
        while true
            [new,cave] = move(cave,old);
            if sum(new == old) == 2
                old = start;
                count = count+1;
                cave(old(1),old(2)) = 2;
                continue
            elseif new(1) == low + 1
                break
            else
                old = new;
            end 
        end
    else %part 2
        while true
            [new,cave] = move(cave,old);
            if sum(new == old) == 2
                if sum(new == start) == 2
                    break
                end
                old = start;
                count = count+1;
                cave(old(1),old(2)) = 2;
                continue
            else
                old = new;
            end 
        end
    end
    function [new,cave] = move(cave,old)
        if ~cave(old(1)+1,old(2))
            cave(old(1)+1,old(2)) = 2;
            cave(old(1),old(2)) = 0;
            new = [old(1)+1,old(2)];
        elseif ~cave(old(1)+1,old(2)-1)
            cave(old(1)+1,old(2)-1) = 2;
            cave(old(1),old(2)) = 0;
            new = [old(1)+1,old(2)-1];
        elseif ~cave(old(1)+1,old(2)+1)
            cave(old(1)+1,old(2)+1) = 2;
            cave(old(1),old(2)) = 0;
            new = [old(1)+1,old(2)+1];
        else
            new = old;
        end
    end
end