clear all
clc
S = str2double(readlines("day25.txt").replace([".",">","v"],string(0:2)).split(""));
S = S(:,2:end-1);
sz = size(S);
count = 0;
while true
    moved = 0;
    temp = S;
    I = find(S == 1);
    for i = 1:numel(I)
        [r,c] = ind2sub(sz,I(i));
        if c == sz(2)
            if S(r,1) == 0
                temp(r,1) = 1; temp(r,c) = 0;
                moved = 1;
            end
        elseif S(r,c+1) == 0
            temp(r,c+1) = 1; temp(r,c) = 0;
            moved = 1;
        end
    end
    S = temp;
    I = find(S == 2);
    for i = 1:numel(I)
        [r,c] = ind2sub(sz,I(i));
        if r == sz(1)
            if S(1,c) == 0
                temp(1,c) = 2; temp(r,c) = 0;
                moved = 1;
            end
        elseif S(r+1,c) == 0
            temp(r+1,c) = 2; temp(r,c) = 0;
            moved = 1;
        end
    end
    count = count + 1;
    if moved == 0
        S = temp;
        break
    end
    S = temp;
end
part_1 = count