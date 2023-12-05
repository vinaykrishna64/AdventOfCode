clear all
filename    = 'input.txt';
S           = readlines(filename);
winners     = str2double(strtrim(S.extractBetween(':','|')).replace('  ',' 0').split(' '));
numbers     = str2double(strtrim(S.extractAfter('|')).replace('  ',' 0').split(' '));
%% part 1
matches = arrayfun(@(x) numel(intersect(winners(x,:),numbers(x,:))),1:numel(S));
score = 2.^(matches-1);
score(score <1 ) = 0;
fprintf('part 1 = %d\n',sum(score))
%% part 2
copies    = ones([numel(S),1]);
for idx = 1:numel(S)
    copies(idx+1:idx+matches(idx)) = copies(idx+1:idx+matches(idx))+copies(idx);
end
fprintf('part 1 = %d\n',sum(copies))
