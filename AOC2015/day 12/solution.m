clear all
clc

S = readlines("input.txt");

%% part 1
S1 = str2double(S.split([":",",","}","]","[","{"]).replace(["i","j"],["k","k"]));
part_1 = sum(S1(~isnan(S1)))

%% part 2


S2 = S.replace(["}","{","]","["],[",},",",{,",",],",",[,"]);
S2 = S2.split(",");
S2 = S2(S2 ~= '');

% find object bracket pairs
I1 = find(S2 == "{"); I2 = find(S2 == "}");
closing = zeros(size(I1));
for i = 1:numel(I1)
    I3 = I2(I2 > I1(i));
    for j = 1:numel(I3)
        if numel(find(I1 >= I1(i) & I1 <= I3(j))) == numel(find(I3 >= I1(i) & I3 <= I3(j)))
            closing(i) = I3(j);
            break
        end
    end
end
M = containers.Map(closing,I1);

% find invalid objects
good = ones(size(S2));
for i = 1:numel(S2)
   
    if contains(S2(i),"red")
        n_o_1 = 0;
        n_o_2 = 0;
        flg = 0;
        for j = i:numel(S2)
            if S2(j) == "]" 
                if ~n_o_2
                    break
                else
                    n_o_2 = n_o_2 - 1;
                end
            elseif S2(j) == "}" 
                if ~n_o_1
                    flg = 1;
                    break
                else
                    n_o_1 = n_o_1 - 1;
                end
            elseif  S2(j) == "{" 
                 n_o_1 = n_o_1 + 1;
            elseif  S2(j) == "[" 
                 n_o_2 = n_o_2 + 1;
            end
        end
        if flg
            good(M(j)+1:j-1) = 0;
        end
    end
end

S21 = strjoin(S2(good == 1),",").replace([",}","{,",",]","[,"],["}","{","]","["]);
S21 = str2double(S21.split([":",",","}","]","[","{"]).replace(["i","j"],["k","k"]));

part_2 = sum(S21(~isnan(S21)))



