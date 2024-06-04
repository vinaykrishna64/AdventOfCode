clc
clear all
P = readlines("day21.txt").split(": ");
P_inp = str2double(P(:,2));

%% part 1
die = 1:100;
S = [0,0];
% P = [4 8]; %test case
die = circshift(die,3); %pre load die to help the loop
rolls = 0;
P = P_inp;
while true
    %player 1 rolls
    die = circshift(die,-3);
    rolls = rolls+1;
    P(1) = moveplayer(P(1),sum(die(1:3)));
    S(1) = S(1) + P(1);
    if  S(1) >= 1000
        fprintf("part 1 = %14d\n",S(2)*rolls*3)
        break
    end
    %player 2 rolls
    die = circshift(die,-3);
    rolls = rolls+1;
    P(2) = moveplayer(P(2),sum(die(1:3)));
    S(2) = S(2) + P(2);
    if S(2) >= 1000
        fprintf("part 1 = %14d\n",S(1)*rolls*3)
        break
    end
end
%% part 2

[wins] = simulate_rolls_reduced(P_inp',[0,0],0);
clear Cache
fprintf('part 2 = %14d\n',max(wins)) 
%% functions
function [wins] = simulate_rolls_reduced(P,S,T)
    % make cache
    persistent Cache
    if isempty(Cache)
        Cache = dictionary();
        Cache{""} = [0 0];
    end
    % set key and check key + scores/win condition
    key = strjoin(string([P,S,T]'),",");
    if isKey(Cache,key)
        wins = Cache{key};
        return
    elseif S(1) >= 21
        wins =  [1 0];
        return
    elseif S(2) >= 21
        wins =  [0 1];
        return
    end
    % each roll has 27 possibilities 3*3
    % but roll values are only from 3-9
    rolls = [3 1; 4 3; 5 6; 6 7; 7 6; 8 3; 9 1];
    wins = [0,0];
    for idx = 1:7
        % turns start ftom 0 and flip betwenn 1-0
        new_P = P; new_S = S;
        new_P(T+1) = moveplayer(new_P(T+1),rolls(idx,1)); 
        new_S(T+1) = new_S(T+1) + new_P(T+1);
        wins = wins +simulate_rolls_reduced(new_P,new_S,1-T)*rolls(idx,2);
    end
    Cache{key} = wins; %update Cache
end

function [p] = moveplayer(p,die)
    p = mod(p+die-1,10) + 1;
end