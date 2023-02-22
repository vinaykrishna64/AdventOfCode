clear all
filename = 'input.txt';
S = readlines(filename).replace(["F","B","L","R"],["1","0","1","0"]).split('');
S = str2double(S(:,2:end-1));
rows = arrayfun(@(x) sel_seat(S(x,1:7),'row'), [1:size(S,1)]);
cols = arrayfun(@(x) sel_seat(S(x,8:10),'col'), [1:size(S,1)]);

ID = rows*8 + cols;
disp(sprintf('part_1 = %d',max(ID)))
ID = sort(ID);
I = find(diff(ID) == 2);
disp(sprintf('part_2 = %d',ID(I)+1))
%%
function [r] = sel_seat(s,flg)
    if flg == 'row'
        R = [0 127];
    elseif flg == 'col'
        R = [0 7];
    end
    for i = 1:numel(s)-1
        if s(i) == 1
            R = [R(1) R(1)+floor((R(2)-R(1))/2)];
        else
            R = [ R(1)+ceil((R(2)-R(1))/2) R(2)];
        end
    end
    if s(numel(s)) == 1
        r = R(1);
    else
        r = R(2);
    end
end


