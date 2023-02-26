clear all
filename = 'input.txt';
S = str2double(readlines(filename));
inds = 1:numel(S);
invalid = 0;
for i = 25:numel(S)
    I = find(inds >= i-25 & inds < i);
    if numel(I)
        s = S(I) + S(I)';
        J = sub2ind(size(s),1:numel(I),1:numel(I));
        s(J) = 0;
        if ~any(s == S(i)) & ~invalid
            invalid = S(i);
            disp(sprintf('part_1 = %d',invalid))
        end
    end
    if invalid
        break
    end
end

flg = 0;
for  i = 1:numel(S)
    for j = i+1:numel(S)
        if sum(S(i:j)) == invalid
            disp(sprintf('part_2 = %d',min(S(i:j)) + max(S(i:j))))
            flg = 1;
            break
        end
    end
    if flg
        break
    end
end