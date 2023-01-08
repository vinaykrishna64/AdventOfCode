clear all
clc

S = readlines("input.txt");
ing = zeros(numel(S),5);
for i = 1:numel(S)
    s = regexp(S(i,:),'[-]?\d*','match');
    ing(i,:) = str2double(s);
end

[part_1,part_2] = search_spoons(ing,[],0,0)

%% functions

function [max_score,max_score_cal] = search_spoons(ing,cache,max_score,max_score_cal)
if numel(cache) == 4
    if sum(cache) == 100
        score = score_cookie(ing,cache);
        if score > max_score
            max_score = score;
        end
        if cal_cookie(ing,cache) == 500 & score > max_score_cal
            max_score_cal = score;
        end
    end
    return
end

for i = 0:100
    [max_score,max_score_cal] = search_spoons(ing,[cache; i],max_score,max_score_cal);
end

end

function score = score_cookie(ing,cache)
    N = repmat(cache,1,4);
    score = sum(N.* ing(:,1:4),1);
    score(score < 0) = 0;
    score = prod(score);
end

function cal = cal_cookie(ing,cache)
    cal = sum(cache .* ing(:,end));
end