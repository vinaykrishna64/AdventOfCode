clear all
filename = 'input.txt';
S = readlines(filename);
I =  find(strcmp(S,""));
S(I) = 'K';
s = strjoin(S','sp');
cal_sets = split(s,'K');

cal = cellfun(@get_calorie,cal_sets );

cal =  sort(cal,'descend');
cal(1)
sum(cal(1:3))
function [S] = get_calorie(set_cal)
C = str2double(split(set_cal,'sp'));
S = sum(C(~isnan(C)));
end