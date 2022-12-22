clear all
clc

S = readlines("input.txt");
I = find(S == "");
map_board = S(1:I-1).char();
map_board(map_board == ' ') = 'x';
sz = size(map_board);
instruc = S(I+1:end);
instruc = instruc.replace(["R","L"],[",R,",",L,"]).split(",");

start = [1, find(map_board(1,:) == '.',1)];
%% part 1
pos = start;
dirs = ["R","D","L","U"];
Fac = containers.Map(dirs,0:3);
for i = 1:numel(instruc)
    if instruc(i) == "R"
        dirs = circshift(dirs,-1);
    elseif instruc(i) == "L"
        dirs = circshift(dirs,1);
    else
        mv = str2double(instruc(i));
        if dirs(1) == "R"
            M = map_board(pos(1),:);
            shift = 0;
            counts = 0;
            while true
                M = circshift(M,-1);
                if M(pos(2)) == '.'
                    shift = shift+1;
                    counts = counts+1;
                elseif M(pos(2)) == 'x'
                    shift = shift+1;
                else
                    shift_back = 0;
                    while true
                        M = circshift(M,1);
                        if M(pos(2)) == 'x'
                            shift_back = shift_back + 1;
                        elseif M(pos(2)) == '.'
                            break
                        end
                    end
                    shift =  shift - shift_back;
                    break
                end
            if counts == mv
                break
            end
        end
        pos(2) = find(circshift(1:sz(2),shift) == pos(2));
    elseif dirs(1) == "L"
        M = map_board(pos(1),:);
        shift = 0;
        counts = 0;
        while true
            M = circshift(M,1);
            if M(pos(2)) == '.'
                shift = shift+1;
                counts = counts+1;
            elseif M(pos(2)) == 'x'
                shift = shift+1;
            else
                shift_back = 0;
                while true
                    M = circshift(M,-1);
                    if M(pos(2)) == 'x'
                        shift_back = shift_back + 1;
                    elseif M(pos(2)) == '.'
                        break
                    end
                end
                shift =  shift - shift_back;
                break
            end
            if counts == mv
                break
            end
        end
        pos(2) = find(circshift(1:sz(2),-shift) == pos(2));
    elseif dirs(1) == "D"
        M = map_board(:,pos(2));
        shift = 0;
        counts = 0;
        while true
            M = circshift(M,-1);
            if M(pos(1)) == '.'
                shift = shift+1;
                counts = counts+1;
            elseif M(pos(1)) == 'x'
                shift = shift+1;
            else
                shift_back = 0;
                while true
                    M = circshift(M,1);
                    if M(pos(1)) == 'x'
                        shift_back = shift_back + 1;
                    elseif M(pos(1)) == '.'
                        break
                    end
                end
                shift =  shift - shift_back;
                break
            end
            if counts == mv
                break
            end
        end
        pos(1) = find(circshift(1:sz(1),shift) == pos(1));
    elseif dirs(1) == "U"
        M = map_board(:,pos(2));
        shift = 0;
        counts = 0;
        while true
            M = circshift(M,1);
            if M(pos(1)) == '.'
                shift = shift+1;
                counts = counts+1;
            elseif M(pos(1)) == 'x'
                shift = shift+1;
            else
                shift_back = 0;
                while true
                    M = circshift(M,-1);
                    if M(pos(1)) == 'x'
                        shift_back = shift_back + 1;
                    elseif M(pos(1)) == '.'
                        break
                    end
                end
                shift =  shift - shift_back;
                break
            end
            if counts == mv
                break
            end
        end
        pos(1) = find(circshift(1:sz(1),-shift) == pos(1));
    end
end
end


part_1 = sum([1000 4] .* pos) + Fac(dirs(1))



%% part 2 manual tunneling
%
%  X  top  S4                         
%  X  S3   X             
%  S1 base X                  
%  S2 X    X           
%
% mapping vetrices from 1 -> 8
L = size(map_board,2)/3; %sidelength
% base = map_board((2*L+1):(3*L), (L+1):(2*L));
% S1 = map_board((2*L+1):(3*L), 1:L);
% S2 = map_board((3*L+1):(4*L), 1:L);
% S3 = map_board((L+1):(2*L), (L+1):(2*L));
% top =   map_board(1:L, (L+1):(2*L));
% S4 = map_board(1:L, (2*L+1):(3*L));

% make tunnels using linear index
LIDX = @(i,j) i + (j-1)*sz(1);
Tunnels = [];
DF_in  = []; %Facing going into tunnel RDLU = 1234
DF_out = []; %Facing after reaching end of tunnel RDLU = 1234
% S2 right edge to BASE bottom edge
Tunnels = [Tunnels; [LIDX((3*L+1):(4*L),L*ones(1,L))' LIDX(3*L*ones(1,L), (L+1):(2*L))']]; 
DF_in = [DF_in ;1*ones(L,1)];
DF_out = [DF_out;4*ones(L,1)];
Tunnels = [Tunnels; fliplr([LIDX((3*L+1):(4*L),L*ones(1,L))' LIDX(3*L*ones(1,L), (L+1):(2*L))'])]; %reverse map
DF_in = [DF_in ;2*ones(L,1)];
DF_out = [DF_out;3*ones(L,1)];
% S2 bottom edge to S4 top edge
Tunnels = [Tunnels; [LIDX(4*L*ones(1,L), 1:L)' LIDX(ones(1,L), (2*L+1):(3*L))']];
DF_in = [DF_in ;2*ones(L,1)];
DF_out = [DF_out;2*ones(L,1)];
Tunnels = [Tunnels; fliplr([LIDX(4*L*ones(1,L), 1:L)' LIDX(ones(1,L), (2*L+1):(3*L))'])]; %reverse map
DF_in = [DF_in ;4*ones(L,1)];
DF_out = [DF_out;4*ones(L,1)];
% S2 left edge to TOP top edge
Tunnels = [Tunnels; [LIDX((3*L+1):(4*L),ones(1,L))' LIDX(ones(1,L), (L+1):(2*L))']];
DF_in = [DF_in ;3*ones(L,1)];
DF_out = [DF_out;2*ones(L,1)];
Tunnels = [Tunnels; fliplr([LIDX((3*L+1):(4*L),ones(1,L))' LIDX(ones(1,L), (L+1):(2*L))'])];%reverse map
DF_in = [DF_in ;4*ones(L,1)];
DF_out = [DF_out;1*ones(L,1)];
% S1 top edge to S3 left edge
Tunnels = [Tunnels; [LIDX((2*L+1)*ones(1,L), 1:L)' LIDX((L+1):(2*L), (L+1)*ones(1,L))']];
DF_in = [DF_in ;4*ones(L,1)];
DF_out = [DF_out;1*ones(L,1)];
Tunnels = [Tunnels; fliplr([LIDX((2*L+1)*ones(1,L), 1:L)' LIDX((L+1):(2*L), (L+1)*ones(1,L))'])];%reverse map
DF_in = [DF_in ;3*ones(L,1)];
DF_out = [DF_out;2*ones(L,1)];
% S1 left edge to TOP left edge -- > there is a flip
Tunnels = [Tunnels; [LIDX((2*L+1):(3*L),ones(1,L))' LIDX(flip(1:L), (L+1)*ones(1,L))']];
DF_in = [DF_in ;3*ones(L,1)];
DF_out = [DF_out;1*ones(L,1)];
Tunnels = [Tunnels; fliplr([LIDX((2*L+1):(3*L),ones(1,L))' LIDX(flip(1:L), (L+1)*ones(1,L))'])];%reverse map
DF_in = [DF_in ;3*ones(L,1)];
DF_out = [DF_out;1*ones(L,1)];
% S3 right edge to S4 bottom edge
Tunnels = [Tunnels; [LIDX((L+1):(2*L),(2*L)*ones(1,L))' LIDX(L*ones(1,L), (2*L+1):(3*L))']]; 
DF_in = [DF_in ;1*ones(L,1)];
DF_out = [DF_out;4*ones(L,1)];
Tunnels = [Tunnels; fliplr([LIDX((L+1):(2*L),(2*L)*ones(1,L))' LIDX(L*ones(1,L), (2*L+1):(3*L))'])];%reverse map
DF_in = [DF_in ;2*ones(L,1)];
DF_out = [DF_out;3*ones(L,1)];
% BASE right edge to S4 right edge -- > there is a flip
Tunnels = [Tunnels; [LIDX((2*L+1):(3*L),2*L*ones(1,L))' LIDX(flip(1:L), 3*L*ones(1,L))']];
DF_in = [DF_in ;1*ones(L,1)];
DF_out = [DF_out;3*ones(L,1)];
Tunnels = [Tunnels; fliplr([LIDX((2*L+1):(3*L),2*L*ones(1,L))' LIDX(flip(1:L), 3*L*ones(1,L))'])];%reverse map
DF_in = [DF_in ;1*ones(L,1)];
DF_out = [DF_out;3*ones(L,1)];

DF_out = string(DF_out).replace(["1","2","3","4"],["R","D","L","U"]);
DF_in = string(DF_in).replace(["1","2","3","4"],["R","D","L","U"]);

pos = start;
dirs = ["R","D","L","U"];
Fac = containers.Map(dirs,0:3);
for i = 1:numel(instruc)
    if instruc(i) == "R"
        dirs = circshift(dirs,-1);
    elseif instruc(i) == "L"
        dirs = circshift(dirs,1);
    else
        mv = str2double(instruc(i));
        while mv
            [pos,flg] = move_pos(dirs(1),pos,map_board,sz);
            if flg == 2
                [df,pos_out] = tunnel_map(Tunnels,DF_in,DF_out,dirs(1),LIDX(pos(1),pos(2)));
                [pos_tr pos_tc]= ind2sub(sz,pos_out);
                if map_board(pos_tr,pos_tc) == '.'
                    pos = [pos_tr pos_tc];
                    mv = mv - 1;
                    while dirs(1) ~= df
                        dirs = circshift(dirs,1);
                    end
                else
                    flg = 0;
                end
            elseif flg == 1
               mv = mv - 1;
            end
            if flg == 0
                break
            end
        end
    end
end

part_2 = sum([1000 4] .* pos) + Fac(dirs(1))

%%
figure("windowstate","maximized")

map_img= str2double(string(map_board).replace([".","#","x"],["1,","0.5,","0,"]).split(','));
imshow(map_img)
hold on
spec = {'r--','b-s','g:','c-^','y-o'};
for i = 1:size(Tunnels,1)
    colour =  spec{mod(floor((i-1)/50),5)+1};
    [r1 c1] = ind2sub(sz,Tunnels(i,1));
    [r2 c2] = ind2sub(sz,Tunnels(i,2));
    plot([c1,c2],[r1,r2],colour)
    hold on
end
title('wrapping map plot')
exportgraphics(gcf,'wrapping_map_plot.jpeg','Resolution',1200)
%% functions

function [df,pos_out] = tunnel_map(Tunnels,DF_in,DF_out,direc,pos)
    I = find(Tunnels(:,1) == pos & DF_in == direc);
    pos_out = Tunnels(I,2);
    df = DF_out(I);
end
function [pos,flg] = move_pos(direc,pos,map_board,sz)
    flg = 0; %stop at wall
    %prompt tunnel & return if moving out of edge
    if (pos(1) == 1 & direc == "U") |...
                    (pos(1) == sz(1) & direc == "D") |...
                    (pos(2) == 1  & direc == "L")|...
                    (pos(2) == sz(2)  & direc == "R") 
        flg = 2;
        return
    end
    %move if possible, or prompt tunnel if found
    if direc == "R"
        if map_board(pos(1),pos(2)+1) == '.'
            pos = pos + [0 1];
            flg = 1; %move flg
        elseif map_board(pos(1),pos(2)+1) == 'x'
            flg = 2; %tunnel flg
        end
    elseif direc == "L"
        if map_board(pos(1),pos(2)-1) == '.'
            pos = pos + [0 -1];
            flg = 1; %move flg
        elseif map_board(pos(1),pos(2)-1) == 'x'
            flg = 2; %tunnel flg
        end
    elseif direc == "D"
        if map_board(pos(1)+1,pos(2)) == '.'
            pos = pos + [1 0];
            flg = 1; %move flg
        elseif map_board(pos(1)+1,pos(2)) == 'x'
            flg = 2; %tunnel flg
        end
    elseif direc == "U"
        if map_board(pos(1)-1,pos(2)) == '.'
            pos = pos + [-1 0];
            flg = 1; %move flg
        elseif map_board(pos(1)-1,pos(2)) == 'x'
            flg = 2; %tunnel flg
        end
    end
end

