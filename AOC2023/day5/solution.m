clear all
filename    = 'input.txt';
S           = readlines(filename);
seeds       = str2double(strtrim(S(1).extractAfter(':')).split(' '));
breaks      = find(S == '');
breaks      = [breaks;numel(S)+1];

for idx = 1:numel(breaks)-1 % cycle layers
    map_set    = str2double(strtrim(S(breaks(idx)+2:breaks(idx+1)-1)).split(' '));
    map_set(:,3) = map_set(:,3) - 1;
    map_cell{idx} = map_set; % record transformations in each layer
end

%% part 1
minloc = 10e20;
for idx = 1:numel(seeds)
    loc = Seed2Loc(seeds(idx),map_cell);
    if loc < minloc
        minloc = loc;
    end
end
fprintf('part 1 = %10d\n',minloc)
%% part 2
current_ranges = [seeds(1:2:end) (seeds(1:2:end)+seeds(2:2:end)-1)]; %seed intervals
current_ranges = sort(current_ranges(:))'; % convert to row
for idx = 1:numel(breaks)-1 % cycle layers
   %% insert each valid map interval limit into the ranges
   map_set       = map_cell{idx};
   set_intervals = [map_set(:,2), map_set(:,2)+map_set(:,3)]; % make intervals
   set_intervals = sort(set_intervals(:))'; % convert to row
   current_ranges = insert_limit(current_ranges,set_intervals);
   %% map layer tranformation
   for jdx = 1:numel(current_ranges)
       current_ranges(jdx) = Convert_layer(current_ranges(jdx),map_set);
   end
   current_ranges = sort(current_ranges(:))'; % sort new intervals
end
fprintf('part 2 = %10d\n',min(current_ranges(:,1)))

%% functions

function [ranges] = insert_limit(ranges,lims)
    for lim_idx = 1:numel(lims)
        if mod(lim_idx,2) == 1 % left limit
            flg = 1;
        else   % right limit
            flg = 2;
        end
        while flg <= numel(ranges)-1
            if (mod(lim_idx,2) == 1)& (ranges(flg) < lims(lim_idx) & ranges(flg+1) > lims(lim_idx)) % inserting left limit
               ranges = [ranges(1:flg) lims(lim_idx) lims(lim_idx)+1 ranges(flg+1:end)];
               flg = flg + 3;
            elseif (mod(lim_idx,2) ==0)& (ranges(flg) > lims(lim_idx) & ranges(flg-1) < lims(lim_idx)) % inserting right limit
               ranges = [ranges(1:flg-1) lims(lim_idx) lims(lim_idx)+1 ranges(flg:end)];
               flg = flg + 3;
            else
                flg = flg + 2;
            end
        end
    end
end
function [loc] = Seed2Loc(seed,map_cell)
    maps       = zeros([8,1]);
    maps(1)    = seed;
    for idx = 1:numel(map_cell)
        map_set     = map_cell{idx};
        maps(idx+1) = maps(idx);
        maps(idx+1) = Convert_layer(maps(idx+1),map_set);
    end
    loc = maps(end);
end


function [out] = Convert_layer(inp,map_set)
    out = inp; % set output = input
    for jdx = 1:height(map_set) % cycle maps
        if (map_set(jdx,2) <= inp) & (inp <= (map_set(jdx,2)+map_set(jdx,3))) % if source in range
            out = map_set(jdx,1) + inp - map_set(jdx,2); % tranform to destination
            break
        end
    end
end

