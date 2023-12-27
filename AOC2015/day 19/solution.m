clear all
clc

L = readlines("input.txt");
I =find(L == "");
d1 = [L(1:I-1).extractBefore(" =>"),L(1:I-1).extractAfter("=> ")];
sq = L(I+1);

Cache = "";

%% part_1

for idx = 1:size(d1,1)
    dummy = sq.split(d1(idx,1));
    I = 2:2:(2*numel(dummy)-1);
    for jdx = 1:numel(dummy)-1;
        test = repmat("",[1,2*numel(dummy)-1]);
        test(1:2:end) = dummy;
        test(I(jdx)) = d1(idx,2);
        test(I([1:numel(I)] ~= jdx)) = d1(idx,1);
        test = strtrim(strjoin(test,""));
        if ~any(strcmp(test,Cache))
            Cache(end+1) = test;
        end
    end
end
fprintf('part 1 = %14d \n',numel(Cache)-1)

%% part_2
d2 = fliplr(d1);
fprintf('part 2 = %14d \n',min_react(sq,d2,100000,0))
function min_steps = min_react(sq,d,min_steps,steps) %min walks back to 'e'
    if steps >= min_steps
        return
    end
    if sq == "e"
        min_steps = steps;
        return
    end
    for idx = 1:size(d,1)
        if contains(sq,d(idx,1))
            dummy = sq.split(d(idx,1));
            I = 2:2:(2*numel(dummy)-1);
            for jdx = 1:numel(dummy)-1;
                test = repmat("",[1,2*numel(dummy)-1]);
                test(1:2:end) = dummy;
                test(I(jdx)) = d(idx,2);
                test(I([1:numel(I)] ~= jdx)) = d(idx,1);
                test = strtrim(strjoin(test,""));
                min_steps = min_react(test,d,min_steps,steps+1);
            end
        end
    end
end






