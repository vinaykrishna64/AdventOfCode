clear all
filename            = 'input.txt';
S                   = readlines(filename);
%% part 1
times               = str2double(strtrim(S(1,:).extractAfter(':')).split(' '));
times(isnan(times)) = [];
dists               = str2double(strtrim(S(2,:).extractAfter(':')).split(' '));
dists(isnan(dists)) = [];
w_c = zeros(size(times));
for idx = 1:numel(times)
    err = [1:times(idx)].*(times(idx)-[1:times(idx)]) - dists(idx);
    w_c(idx) = numel(err(err>0));
end
fprintf('part_1 = %d\n',prod(w_c))

%% part 2
time = str2double(S(1,:).extractAfter(':').replace(' ',''));
dist = str2double(S(2,:).extractAfter(':').replace(' ',''));
err = [1:time].*(time-[1:time]) - dist;
fprintf('part_2 = %d\n',numel(err(err>0)))

































































