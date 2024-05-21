clear all
clc
filename = 'input.txt';
S = readlines(filename);
I = find(S == "");

p1 = str2double(S(2:I-1)); 
p2 = str2double(S(I+2:end));
part_1(p1,p2) %part 1
[p1,p2] = game(p1,p2);
print_scr(p1,p2,2)
%%
function [p1,p2,winner] = game(p1,p2)
    cache = state_make(p1,p2);
    while numel(p1) & numel(p2)
        % each round
        if p1(1) <= numel(p1)-1 & p2(1) <= numel(p2)-1 % if equal are less cards call new game
            [~,~,winner] = game(copy_cards(p1),copy_cards(p2));
        else % if have more cards play round
            [winner] = round(p1,p2);
        end
        % settle round victory
        if winner == 1
           p1 = circshift(p1,-1);
           p1 = [p1; p2(1)];
           p2(1) = [];
        else
           p2 = circshift(p2,-1);
           p2 = [p2; p1(1)];
           p1(1) = [];
        end
        % update cache
        cache = [cache;state_make(p1,p2)];
        if any(strcmp(cache(end),cache(1:end-1))) %check recursion
            winner = 1;
            return
        end
    end
end
function [out] = state_make(p1,p2)
   out = strcat(strjoin(string(num2str(p1)),","),"+",strjoin(string(num2str(p2)),","));
end
function [p] = copy_cards(p)
    p = p(2:2+p(1)-1);
end
function [winner] = round(p1,p2)
    if p1(1) > p2(1)
        winner = 1;
    else 
        winner = 2;
    end
end
function [] = part_1(p1,p2)
    while numel(p1) & numel(p2)
        if p1(1) > p2(1)
           p1 = circshift(p1,-1);
           p1 = [p1; p2(1)];
           p2(1) = [];
        else
           p2 = circshift(p2,-1);
           p2 = [p2; p1(1)];
           p1(1) = [];
        end
    end
    print_scr(p1,p2,1)
end
function [] = print_scr(p1,p2,part_no)
    if numel(p1) 
            fprintf('part %d = %14d \n',part_no,sum(p1' .* flip(1:numel(p1))))
        else
            fprintf('part %d = %14d \n',part_no,sum(p2' .* flip(1:numel(p2))))
    end
end