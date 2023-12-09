clear all
filename            = 'input.txt';
S                   = readlines(filename);

for idx = 1:numel(S)
    val(idx,:) = extrap_p1(S(idx));
end
fprintf('part_1 = %10d\n',sum(val(:,2)))
fprintf('part_2 = %10d\n',sum(val(:,1)))
function [val] = extrap_p1(sq)
    sq = {[str2double(sq.split(' '))]};
    while true
        sq{end+1}= diff(sq{end});
        if all(sq{end} ==0 )
            break
        end
    end
    val(2) = 0;
    for idx = numel(sq)-1:-1:1
        val(2) = val(2) + sq{idx}(end);
    end
    val(1) = 0;
    for idx = numel(sq)-1:-1:1
        val(1) =  sq{idx}(1) - val(1);
    end
end