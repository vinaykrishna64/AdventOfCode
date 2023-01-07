clear all
clc

S = str2double(readlines("input.txt").split(": "));
        %cost damage heal mana armour effect turns
spells = [53  4 0 0   0 0 0;
          73  2 2 0   0 0 0;
          113 0 0 0   7 1 6;
          173 3 0 0   0 1 6;
          229 0 0 101 0 1 5];
effects = zeros(1,3); %toggle
counter = zeros(1,3); % active turn count

boss = S(:,2)';
player = [50 500 0];%hp mana armour 

part_1 = fights_min_mana(spells,effects,counter,player,boss,10000,1,0,0)  
part_2 = fights_min_mana(spells,effects,counter,player,boss,10000,1,0,1)  

%% functions
function [min_mana] = fights_min_mana(spells,effects,counter,player,boss,min_mana,t,mana_used,hard)
    if t & hard %hardmode condition
        player(1) = player(1) - 1;
        if player(1) <= 0 %player dead         
            return
        end
    end
    player(3) = 0;
    P_eff = [0 0 0];
    B_eff = [0 0];
    for i = 1:3 % check effects
        if effects(i) & counter(i)
            counter(i) = counter(i) - 1;%set counter
            if i == 1
                P_eff(3) =  spells(3,5);
            elseif  i == 2
                B_eff(1) = B_eff(1) -spells(4,2);
            elseif i == 3
                P_eff(2) = P_eff(2) + spells(5,4);
            end 
        elseif effects(i) & ~counter(i)
            effects(i) = 0; % toggle effect
        end
    end
    boss = boss + B_eff;
    player = player + P_eff;
    if boss(1) <= 0 | player(1) <= 0 %player | boss dead
        if boss(1) <= 0 & player(1) & mana_used < min_mana
            min_mana = mana_used;
        end
        return
    end
    if t      
        % use spells
        for i = 1:5
            if player(2) >= spells(i,1)
                if i > 2
                    L = effects; L(i-2) = 1; % toggle effect
                    C = counter; C(i-2) = spells(i,end); %set counter
                    P = [0 -spells(i,1) 0];
                    B = [0 0];
                    min_mana = fights_min_mana(spells,L,C,...
                        player + P,boss+B,min_mana,1-t,mana_used + spells(i,1),hard);
                else
                    P = [spells(i,3) -spells(i,1) 0];
                    B = [-spells(i,2) 0];
                    min_mana = fights_min_mana(spells,effects,counter,...
                        player + P,boss+B,min_mana,1-t,mana_used + spells(i,1),hard);
                end
            end
        end
    else
        P_boss =[(player(3) - boss(2)) 0 0];
        min_mana = fights_min_mana(spells,effects,counter,player+P_boss...
            ,boss,min_mana,1-t,mana_used,hard);
    end
end





