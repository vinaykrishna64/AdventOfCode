clear all
filename = 'input.txt';
S = readlines(filename);

s = {};
collect = '';
i = 1;
grp_sz = 1;
p2 = 0;
while i <= numel(S)+1
    if i <= numel(S)
        if S(i) == ""
            grp_sz = grp_sz - 1;
            s{end+1} = unique(collect);
            counts = arrayfun(@(x) count(collect,x) ,s{end});
            p2 = p2 + sum(counts == grp_sz);
            collect = '';
            grp_sz = 0;
        else
            collect = [collect S(i).char()];
        end
        grp_sz = grp_sz + 1;
        i = i + 1;
    else %last collect
        grp_sz = grp_sz - 1;
        s{end+1} = unique(collect);
        counts = arrayfun(@(x) count(collect,x) ,s{end});
        p2 = p2 + sum(counts == grp_sz);
        collect = '';
        grp_sz = 0;
        i = i+1;
    end
end


disp(sprintf('part_1 = %d',sum(cellfun(@numel,s))))

disp(sprintf('part_2 = %d',p2))
