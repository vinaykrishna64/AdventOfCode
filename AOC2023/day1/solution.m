clear all
filename  = 'input.txt';
S         = readlines(filename);
[cal_val] = callibrate(S);
fprintf('1) the sum of all of the calibration values = %d \n',cal_val)

% replace words to numbers before callibrating
S2        = arrayfun(@(x) words2nums(x),S); 
[cal_val] = callibrate(S2);
fprintf('2) the sum of all of the calibration values = %d \n',cal_val)


function [cal_val] = callibrate(S) % callibrates the trebuchet
    S         = arrayfun(@(x) x.split(''),S,"UniformOutput",false);
    numbers   = cellfun(@(x) numout(x), S);
    cal_val   = sum(numbers);
    function [out] = numout(S)
        S = real(str2double(S));
        nums = S(~isnan(S) & S ~= 0);
        out = 10*nums(1) + nums(end);
    end
end

function [S] = words2nums(S) % converts words to numbers
    numlist = ["one","two","three","four","five","six","seven","eight","nine"]; % numbers in strings
    numlist_replace = ["o1e", "t2o", "t3e", "4", "5e", "6", "7n", "e8t", "9e"]; % replace words so they don't hinder other words
    for idx = 1:9
        S = strrep(S,numlist(idx),numlist_replace(idx));
    end
end