clear all
clc

S = readlines("input.txt").erase(":");
catg = ["children";
        "cats";
        "samoyeds";
        "pomeranians";
        "akitas";
        "vizslas";
        "goldfish";
        "trees";
        "cars";
        "perfumes"]; %categories
M = containers.Map(catg,1:10);
sue = repmat([3,7,2,3,0,0,5,3,2,1],500,1);
aunts = nan(500,10);

for i = 1:500
    s = S(i).split(" ");
    for j = 3:2:numel(s)
        aunts(i,M(s(j))) = str2double(s(j+1));
    end
end
%% part 1
aunts1 = aunts;
aunts1(isnan(aunts)) = sue(isnan(aunts));
[~,part_1] = ismember(zeros(1,10),aunts1 - sue,"rows")

%% part 2
aunts2 = aunts;
scores = zeros(500,1);
for i = 1:10
    if  any(i == [2,8])
        s = aunts2(:,i) > sue(:,i);
    elseif any(i == [4,7])
        s = aunts2(:,i) < sue(:,i);
    else
        s = aunts2(:,i) == sue(:,i);
    end
    scores(s) = scores(s) + 1;
    s = isnan(aunts2(:,i));
    scores(s) = scores(s) + 1;
end

part_2 = find(scores == 10)



