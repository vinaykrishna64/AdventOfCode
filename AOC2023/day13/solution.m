% clear all
filename            = 'input.txt';
S                   = readlines(filename);
I = [0; find(S == ''); numel(S)+1];

p1 = 0; 
p2 = 0;
old = zeros(numel(I)-1,2); new = old;
for idx = 1:numel(I)-1
    s = S(I(idx)+1:I(idx+1)-1);
    r = find_reflections(s);
    if r
        old(idx,1) = r;
    else
        old(idx,2) = find_reflections(rotate_s(s));
    end
    if old(idx,2)
        r = fix_smudge(s,old(idx,1));
        if r
            new(idx,1) = r;
        else
            new(idx,2) = fix_smudge(rotate_s(s),old(idx,2));
        end
    else
        r = fix_smudge(rotate_s(s),old(idx,2));
        if r
            new(idx,2) = r;
        else
            new(idx,1) =  fix_smudge(s,old(idx,1));
        end
    end
   
end

fprintf('part 1 = %14d \n',sum(100*old(:,1) + old(:,2)))
fprintf('part 2 = %14d \n',sum(100*new(:,1) + new(:,2)))


function [new] = fix_smudge(s,old)
    new = [];
    s_int = str2double(s.replace([".","#"],["0","1"]).split(''));
    s_int = s_int(:,2:end-1);
    for idx = 1:size(s_int,1)-1
        check = sum(abs(repmat(s_int(idx,:),[size(s_int,1)-idx, 1]) - s_int(idx+1:end,:)),2); % finds what lines have exactly 1 point difference with current line
        I = find(check == 1); % get their indices
        for jdx = 1:numel(I) % try replacing each one of them 
            dummy = s;
            dummy(I(jdx)+idx) = dummy(idx);
            new = find_reflections(dummy); % see if reflections occur
            if new & ~old % if the old reflection was not in this mode 'row' or 'column'
                return
            elseif new 
                new = setdiff(new,old); % check if there are new relfections with the old one, then take the new one
                if new 
                    return
                end
            end
        end
    end
    new = old;
    return
end


function [out] = find_reflections(s)
    out = [];
    R = find(strcmp(s(1:end-1),s(2:end)));
    for idx = 1:numel(R)
        r = R(idx);
        if r <= numel(s)/2
            matches = sum(strcmp(s(1:r),flip(s(r+1:2*r))));
            if matches == r
                out = [out;r];
            end
        else
            matches = sum(strcmp(s((r-(numel(s)-r)+1):r),flip(s(r+1:end))));
            if matches == numel(s)-r
                out = [out;r];
            end
        end
    end
end

function [s] = rotate_s(s)
    s = s.split('')'; s = s(2:end-1,:).join('');
end