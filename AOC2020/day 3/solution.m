clear all
filename = 'input.txt';
S = str2double(readlines(filename).replace([".","#"],["0","1"]).split(''));
S = S(:,2:end-1);


slopes = [1,1;...
    3,1;...
    5,1;...
    7,1;...
    1,2];

for i = 1:size(slopes,1)
    trees(i) = count_trees(S,slopes(i,:));
end

disp(sprintf('part_1 = %d',trees(2)))
disp(sprintf('part_2 = %d',prod(trees)))

function [trees] = count_trees(S,slope)
    sz = size(S);
    reps = ceil(slope(1)*sz(1)/sz(2));
    S = repmat(S,[1,reps]);
    rows = [1:slope(2):sz(1)];
    cols = slope(1)*([1:numel(rows)]-1)+1;
    I = sub2ind(size(S),rows,cols);
    trees = sum(S(I)==1);
end