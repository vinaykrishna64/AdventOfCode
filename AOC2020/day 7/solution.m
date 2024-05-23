clear all
clc
filename = 'input.txt';
S = readlines(filename);
S = S.erase([" bags"," bag","."]).split(" contain ");

rules = dictionary();
for idx = 1:length(S)
    if strcmp(S(idx,2),"no other")
        rules{S(idx,1)} = ["0", "0"];
    else
        s_temp = S(idx,2).split(", ");
        s_temp = s_temp.split(" ");
        if iscolumn(s_temp) 
            s_temp = s_temp';
        end
        rules{S(idx,1)} = [s_temp(:,1), s_temp(:,2:3).join(" ")];
    end
end
%% part 1
tgt = "shiny gold";
k = keys(rules);
p1 = 0;
for idx = 1:numel(k)
    if ~strcmp(k(idx),tgt)
        p1 = p1 + check_bag(k(idx),rules,tgt);
    end
end
fprintf('part 1 = %14d \n',p1)

fprintf('part 2 = %14d \n',count_bags(tgt,rules,0))
%%

function [out] = check_bag(outer,rules,tgt)
    out = 0;
    rule = rules{outer};
    if any(strcmp(rule(:,2),tgt)) 
        out = 1;
        return
    elseif any(strcmp(rule(1,2),"0"))
         return
    else
       for idx = 1:size(rule,1)
           [out] = check_bag(rule(idx,2),rules,tgt);
           if out 
               return
           end
       end
    end
end



function [bg_count] = count_bags(outer,rules,bg_count)
    rule = rules{outer};
    if any(strcmp(rule(1,2),"0"))
         return
    else
       for idx = 1:size(rule,1)
           for jdx = 1:str2double(rule(idx,1))
               [bg_count] = count_bags(rule(idx,2),rules,bg_count+1);
           end
       end
    end
end