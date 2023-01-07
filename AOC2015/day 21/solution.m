clear all
clc

S = str2double(readlines("input.txt").split(": "));
boss = S(:,2)';
player = [100 0 0];
equip = [0 0 0];
S = readlines("shop.txt");
shop = zeros(15,3);
j = 1;
for i = 1:numel(S)
    s = regexp(S(i,:),'\d*','match');
    if numel(s) == 3
        shop(j,:) = str2double(s); j = j + 1;
    elseif numel(s) == 4
        shop(j,:) = str2double(s(2:end)); j = j + 1;
    end
end
shop = [shop(1:5,:); [0 0 0]; shop(6:10,:); [0 0 0]; [0 0 0]; shop(11:16,:)];
[part_1 part_2] = shopping(shop,player,boss,equip,0,10000,zeros(1,19),0)

%% functions
function [min_spend,max_spend] = shopping(shop,player,boss,equip,spend,min_spend,track,max_spend)
    if fightSim(player,boss) & equip_check(equip)
        if spend < min_spend
            min_spend = spend;
            return
        end
    elseif ~fightSim(player,boss) & equip_check(equip)
        if spend > max_spend
            max_spend = spend;
            return
        end
    end
    
    if equip(1) ~= 1 %buy weapon first
        for i = 1:5
            if ~track(i)
                L = [1 0 0];
                L2 = zeros(size(track)); L2(i) = 1;
                P = [0 shop(i,2:end)];
                [min_spend,max_spend] = shopping(shop,player + P ,boss ...
                    ,equip + L,spend + shop(i,1),min_spend,track + L2,max_spend);
            end
        end
    end
  
    if equip(2) ~= 1
        for i = 6:11
            if ~track(i)
                L = [0 1 0];
                L2 = zeros(size(track)); L2(i) = 1;
                P = [0 shop(i,2:end)];
                [min_spend,max_spend] = shopping(shop,player + P ,boss ...
                    ,equip + L,spend + shop(i,1),min_spend,track+L2,max_spend);
            end
        end
    end
    if equip(3) ~= 2 % rings
        for i = 12:19
            if ~track(i)
                L = [0 0 1];
                L2 = zeros(size(track)); L2(i) = 1;
                P = [0 shop(i,2:end)];
                [min_spend,max_spend] = shopping(shop,player + P ,boss ...
                    ,equip + L,spend + shop(i,1),min_spend,track+L2,max_spend);
            end
        end
    end
    
end





function [out] = equip_check(equip)
    out = equip(1) == 1 &  equip(2) == 1 & equip(3) == 2;
end

function [out] = fightSim(player,boss)
    b = max(boss(2) - player(3),1); 
    p = max(player(2) - boss(3),1);
    p_dead = ceil(player(1)/b); b_dead = ceil(boss(1)/p);
    if p_dead >= b_dead
        out = 1;
    else
        out = 0;
    end
end



