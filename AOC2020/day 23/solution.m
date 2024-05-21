clear all
clc
inp = "284573961";
%% part 1

S = str2double(inp.split(''));
cups = dictionary(S(2:end-1),circshift(S(2:end-1),-1));
crnt = S(2);
cups = make_move(cups,crnt,9,100);
p1 = cups(1);
while p1(end) > 1
    p1 = [p1;cups(p1(end))];
end
fprintf('part 1 = %s \n',strjoin(string(num2str(p1(1:end-1))),''))

%% part 2
tic
S = str2double(inp.split(''));
S = [S(2:end-1); [10:10^6]'];
cups = dictionary(S,circshift(S,-1));
crnt = S(1);
cups = make_move(cups,crnt,10^6,10^7);
fprintf('part 2 = %14d \n',cups(1)*cups(cups(1)))
toc
%%

function [cups,nxt] = make_move(cups,crnt,max_cup,iters)
    for idx = 1:iters
        picks = cups(crnt);
        while numel(picks) < 3
            picks = [picks; cups(picks(end))];
        end
        dest = crnt-1;
        if ~dest
            dest = max_cup;
        end
        while any(dest == picks)
            dest = dest-1;
            if ~dest
                dest = max_cup;
            end
        end 
        % move cups
        links_to = [cups(picks(end)); picks(1); cups(dest)];
        links_from = [crnt; dest; picks(end)];
        cups(links_from) = links_to;
        crnt = cups(crnt);%next cup
    end
end
 