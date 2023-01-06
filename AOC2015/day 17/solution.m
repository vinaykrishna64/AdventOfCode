clear all
clc

cans = sort(str2double(readlines("input.txt")),"descend")';
% cans = [20 15 10 5 5];
fills = zeros(size(cans));
%% part 1
[part_1,cache] = fillings(cans,fills,0,150,fills,1);
part_1
%% part_2
cache = cache(2:end,:); 
n_cans = sum(cache,2);
part_2 = numel(find(n_cans == min(n_cans)))



function [ways,cache] = fillings(cans,fills,ways,cap,cache,track)
    if cap == 0
        ways = ways + 1;
        cache = [cache; fills];
        return
    elseif cap < 0 
        return
    end
    for i = track:numel(cans) %% the track saves duplicating cache/seaches
        if ~fills(i)
            L = zeros(size(fills));
            L(i) = 1;
            [ways,cache] = fillings(cans,fills + L,ways,cap - cans(i),cache,i);
        end
    end
end



