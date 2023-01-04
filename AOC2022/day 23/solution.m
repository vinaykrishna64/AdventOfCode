%% part 1
clear all
clc

S = readlines("input.txt").split("").replace([".","#"],["0","1"]);
S = str2double(S.replace([".","#"],["0","1"]));
S = S(:,2:end-1);
S = padarray(S,[300 300],0,'both');

sz = size(S);
I = find(S == 1);
[r,c] = ind2sub(size(S),I);
elves = [r,c];
N = size(elves,1);
Dir_master = [1,3,4,2]; %north east south west = 1234
for moves = 1:10
    next = zeros(N,2);
    Neighbours = zeros(N,4);
    for i = 1:N
       Neighbours(i,:) =  check_neighbours(S,elves(i,:),sz);
       next(i,:) = elves(i,:) + move_elf(elves(i,:),Dir_master,Neighbours(i,:));
    end
    LIndex = elves(:,1)+ (elves(:,2)-1)*sz(1);
    S(LIndex) = 0;
    LIndex = next(:,1) + (next(:,2)-1)*sz(1);
    for i = 1:N
        if sum(LIndex == LIndex(i)) == 1
            elves(i,:) = next(i,:);
        end
    end
    LIndex = elves(:,1)+ (elves(:,2)-1)*sz(1);
    S(LIndex) = 1;
    Dir_master = circshift(Dir_master,-1);
%     S2 = repmat(".",sz);
%     S2(LIndex) = '#';
%     join(S2)
end

bnds = [min(elves,[],1) max(elves,[],1)  ];
part_1 = numel(find(S(bnds(1):bnds(3),bnds(2):bnds(4)) == 0))

%% part 2

clear all


S = readlines("input.txt").split("").replace([".","#"],["0","1"]);
S = str2double(S.replace([".","#"],["0","1"]));
S = S(:,2:end-1);
S = padarray(S,[300 300],0,'both');

sz = size(S);
I = find(S == 1);
[r,c] = ind2sub(size(S),I);
elves = [r,c];
N = size(elves,1);
Dir_master = [1,3,4,2]; %north east south west = 1234
count = 0;
while true
    count = count + 1;
    next = zeros(N,2);
    Neighbours = zeros(N,4);
    for i = 1:N
       Neighbours(i,:) =  check_neighbours(S,elves(i,:),sz);
       next(i,:) = elves(i,:) + move_elf(elves(i,:),Dir_master,Neighbours(i,:));
    end
    if sum(elves == next,"all") == 2*N
        break
    end
    LIndex = elves(:,1)+ (elves(:,2)-1)*sz(1);
    S(LIndex) = 0;
    LIndex = next(:,1) + (next(:,2)-1)*sz(1);
    for i = 1:N
        if sum(LIndex == LIndex(i)) == 1
            elves(i,:) = next(i,:);
        end
    end
    LIndex = elves(:,1)+ (elves(:,2)-1)*sz(1);
    S(LIndex) = 1;
    Dir_master = circshift(Dir_master,-1);
end

part_2 = count
%% functions
function [move] = move_elf(elf,Dirs,Neighbours)
move = [0 0];
if all(Neighbours == 0 | isnan(Neighbours)) %don't move
    return
end
Move_inst = [-1 0; 0 1; 1 0; 0 -1];
    for i = 1:4
        if i ~= 1
            Dirs = circshift(Dirs,-1);
        end
        if Neighbours(Dirs(1)) == 0 % move if free
            move = move + Move_inst(Dirs(1),:);
            break
        end
    end
end





function [out] =  check_neighbours(S,elf,sz)
out = [nan nan nan nan]; %[N E S W] 

%north
if elf(1) ~= 1
    if elf(2) == 1
        out(1) = sum(S(elf(1)-1,elf(2):elf(2)+1));
    elseif elf(2) == sz(2)
        out(1) = sum(S(elf(1)-1,elf(2)-1:elf(2)));
    else
        out(1) = sum(S(elf(1)-1,elf(2)-1:elf(2)+1));
    end
end

%south
if elf(1) ~= sz(1)
    if elf(2) == 1
        out(3) = sum(S(elf(1)+1,elf(2):elf(2)+1));
    elseif elf(2) == sz(2)
        out(3) = sum(S(elf(1)+1,elf(2)-1:elf(2)));
    else
        out(3) = sum(S(elf(1)+1,elf(2)-1:elf(2)+1));
    end
end
     
%east
if elf(2) ~= sz(2)
    if elf(1) == 1
        out(2) = sum(S(elf(1):elf(1)+1,elf(2)+1));
    elseif elf(1) == sz(1)
        out(2) = sum(S(elf(1)-1:elf(1),elf(2)+1));
    else
        out(2) = sum(S(elf(1)-1:elf(1)+1,elf(2)+1));
    end
end

%west
if elf(2) ~= 1
    if elf(1) == 1
        out(4) = sum(S(elf(1):elf(1)+1,elf(2)-1));
    elseif elf(1) == sz(1)
        out(4) = sum(S(elf(1)-1:elf(1),elf(2)-1));
    else
        out(4) = sum(S(elf(1)-1:elf(1)+1,elf(2)-1));
    end
end
end