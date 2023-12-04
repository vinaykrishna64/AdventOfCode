clear all
filename    = 'input.txt';
S           = readlines(filename);
S           = strtrim(S.split(':'));
cards       = S(:,2);

%% part 1
for idx = 1:size(S,1)
    card = strtrim(cards(idx).split('|'));
    winners = str2double(card(1).split(' '));
    numbers = str2double(card(2).split(' '));
    matches(idx) = numel(intersect(winners,numbers));
end
score = 2.^(matches-1);
score(score <1 ) = 0;

fprintf('part 1 = %d\n',sum(score))
%% part 2
scratched = 1;
copies    = ones([numel(cards),1]);
for idx = 1:numel(cards)
    if matches(idx)
        st_cpy = min(idx+1,numel(cards));
        en_cpy = min(idx+matches(idx),numel(cards));
        copies(st_cpy:en_cpy) = copies(st_cpy:en_cpy)+copies(idx);
    end
end
fprintf('part 1 = %d\n',sum(copies))
