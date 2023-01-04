clear all
close all
clc

S =  str2double(readlines("input.txt").replace(["<",">"],["-1,","1,"]).split(","));
S = S(~isnan(S));
%% part_1
H = simulate_tetris(2022,S); 
fprintf("part 1 = %20d \n",H(end))
H = simulate_tetris(50,S,1,"part1.gif"); %make Gif
%% part_2
% find Instruction set repeat point
c = 0;
B = 1:5;
I = 1:numel(S);
while true
    c = c+1;
    B = circshift(B,-1); % brick rotation
    I = circshift(I,-1); % instruction rotation
    if B(1) == 1 & I(1) == 1
        break
    end
end
Target = 1000000000000;
[St,Sz,H1,H2] = find_pattern(S,c);
H = simulate_tetris((mod(Target-St,Sz)+Sz+St),S);
H3 = H(end);
part_2 = H1 ... %        the initial part 
    +   (H2 - H1)*floor((Target-St)/Sz) ... %patterns formed
    + (H3 - H2);       %remainder         
fprintf("part 2 = %20d \n",part_2)

%% functions
function [St,Sz,H1,H2] = find_pattern(S,c)
    H = simulate_tetris(3*c,S);
    h = diff(H);
    hf = fliplr(h);
    Sz = floor(c/2);
    %find pattern size from behind
    while true
        if isequal(hf(1:Sz),hf(Sz+1:2*Sz))
            break
        end
        Sz = Sz + 1;
    end
    % sue it to find pattern start
    St = 1;
    while true
        if isequal(h(St:(St+Sz-1)),h((St+Sz):(St+2*Sz-1)))
            break
        end
        St = St + 1;
    end
    H1 = H(St);
    H2 = H(St+Sz);
end
function [H] = simulate_tetris(N,S,plt,fname)
    rep_point = 0;
    if nargin < 3
        plt = 0;
        fname = "";
    end
    rocks = {ones(1,4),[0 1 0; 1 1 1;0 1 0],[0 0 1; 0 0 1; 1 1 1],ones(4,1),ones(2)};
    

    screen = zeros(90,9); %screen
    screen(end,:) = 1; screen(:,1) = 1; screen(:,end) = 1;   
    dels = 0;
    del_size = 10;

    H = zeros(1,N);
    for n = 1:N
        r_n = n - 5*floor((n-1)/5);
        rock = rocks{r_n};
        toplevels = find(sum(screen(:,2:end-1),2) == 0);
        pos = [toplevels(end)-2-size(rock,1),4]; 
        if toplevels(end) <= 10 %delete last rows when screen is about to fill
            screen = del_rows(screen,del_size);
            if plt == 1
                figure("WindowState","maximized")
                imshow(1 - place_brick(pos,rock,screen))
                exportgraphics(gcf,fname,'Append',true)
            end
            dels = dels + 1;
            toplevels = find(sum(screen(:,2:end-1),2) == 0);
            pos = [toplevels(end)-2-size(rock,1),4]; 
        end
        rest = 0;
        if plt == 1
            figure("WindowState","maximized")
            imshow(1 - place_brick(pos,rock,screen))
            exportgraphics(gcf,fname,'Append',true)
        end
        while ~rest
            [pos,rest] = move_brick(pos,rock,screen,S(1));
            S = circshift(S,-1);
            if plt == 1
                figure("WindowState","maximized")
                imshow(1 - place_brick(pos,rock,screen))
                exportgraphics(gcf,fname,'Append',true)
            end
        end
        screen = place_brick(pos,rock,screen);
        toplevels = find(sum(screen(:,2:end-1),2) == 0);
        H(n) = size(screen,1) - toplevels(end) - 1 + dels*del_size;
        close all
    end
    
end


function [pos,rest] = move_brick(pos,rock,screen,S)
    rest = 0;
    sz = size(rock)-1;
    rows = pos(1):(pos(1)+sz(1));
    cols = pos(2):(pos(2)+sz(2));
    flg = 0;
    %  side movement
    if ~any((rock + screen(rows,cols+S)) == 2,"all")
        pos = pos + [0 S];
        flg = 1;
    end
    %  down movement
    if ~any((rock + screen(rows+1,cols+S*flg)) == 2,"all")
        pos = pos + [1 0];
    else
        rest = 1;
    end
end

function [screen] = del_rows(screen,n)        
screen = circshift(screen,n,1);
screen(1:n,2:end-1) = 0;
end
function [screen] = place_brick(pos,rock,screen)
    sz = size(rock)-1;
    rows = pos(1):(pos(1)+sz(1));
    cols = pos(2):(pos(2)+sz(2));
    screen(rows,cols) = screen(rows,cols) + rock;
end