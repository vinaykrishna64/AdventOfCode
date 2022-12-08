clear all
clc
tic
S = str2double(num2cell(readlines("input.txt").char()));

%%
I_x = repmat( [2:(size(S,1)-1)]', 1, size(S,2)-2);
I_y = repmat( [2:(size(S,2)-1)],  size(S,1)-2,1);

%part 1
visbility = arrayfun(@(x,y) any(S(x,1:(y-1)) >= S(x,y)) &...
    any(S(x,(y+1):end) >= S(x,y)) &...
    any(S(1:(x-1),y) >= S(x,y)) &...
    any(S((x+1):end,y) >= S(x,y)),I_x(:),I_y(:));

sz = size(S);
part_1 = sum(1 - visbility) + 2 * (sz(1) + sz(2) -2)

%part 2

visbility_score = arrayfun(@(x,y) score_make(S(x,1:(y-1)), S(x,y),y,"r") *...
    score_make(S(x,(y+1):end), S(x,y),y,"l") *...
    score_make(S(1:(x-1),y), S(x,y),x,"u") *...
    score_make(S((x+1):end,y),S(x,y),x,"d"),I_x(:),I_y(:));

part_2 = max(visbility_score)

%plots
figure
imshow(1-reshape(visbility,size(S,1)-2,size(S,2)-2))
title('visibility')
exportgraphics(gcf,'visibility_map.jpeg','Resolution',1200)
figure
imshow( reshape(visbility_score,size(S,1)-2,size(S,2)-2)/part_2)
title('visibility score')
exportgraphics(gcf,'visibility_score_map.jpeg','Resolution',1200)
%%
function [out] = score_make(S,s,xy,cmd)
    I = find(S >= s);
    
    if cmd == "r" % if looking right
        if numel(I) %if blocked
            out = xy - I(end);
        else %if not blocked
            out = xy - 1;
        end
    elseif cmd == "l" % if looking left
        if numel(I) %if blocked
            out = I(1);
        else %if not blocked
            out = numel(S);
        end
    elseif cmd == 'u' % if looking up
        if numel(I) %if blocked
            out = xy - I(end);
        else %if not blocked
            out = xy - 1;
        end
    elseif cmd == 'd' % if looking down
        if numel(I) %if blocked
            out =  I(1);
        else %if not blocked
            out = numel(S);
        end
    end
end