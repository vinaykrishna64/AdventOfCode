clear all
clc
filename = 'input.txt';
S = readlines(filename);
I = find(S == "");
rules = parse_rules(S(1:I-1));
messages = S(I+1:end);
expr = get_regexp(0,rules);
for idx = 1:numel(messages)
    matches(idx) = check_exact_match(messages(idx),expr);
end
fprintf('part 1 = %14d \n',sum(matches))

%% part 2 stuff
expr42 = get_regexp(42,rules);
expr31 = get_regexp(31,rules);

expr8  = "(" + expr42 + ")+";
for iter = 1:20
    expr11 =  "(" + expr42 + ")"+ sprintf("{%d}",iter)+ "(" + expr31  + ")"+ sprintf("{%d}",iter);
    for idx = 1:numel(messages)
        if ~matches(idx)
            matches(idx) = check_exact_match(messages(idx),rule_0(expr8,expr11));
        end
    end
end
fprintf('part 2 = %14d \n',sum(matches))

%%
function [expr] = rule_0(expr8,expr11)
    expr = "(" + expr8 + ")(" + expr11 + ")";
end
function [out] = check_exact_match(message,expr)
    [ST,EN] = regexp(message,expr);
    out = 0;
    if ST == 1 & EN == strlength(message)
        out = 1;
    end
end
function [rules] = parse_rules(S)
    % parse_rules(S)
    S = S.erase('"').split(": ");    
    % adjust rule indices
    rules = S(:,2);
    rule_no = str2double(S(:,1));
    rules = dictionary(rule_no,rules);
end

function [expr] = rule2regexp(rule,rules)
   if strcmp(rule,"a") | strcmp(rule,"b")
        expr =  rule;
   elseif contains(rule,"|")
        sub_rules = split(rule, " | ");
        expr = "((" + rule2regexp(sub_rules(1),rules) + ")|(" + rule2regexp(sub_rules(2),rules)+ "))";
   else
       rule_no = str2double(split(rule," "));
       expr = "";
       for idx = 1:numel(rule_no)
            expr = expr + "(" + get_regexp(rule_no(idx),rules) + ")";
       end
   end
end

function [expr] = get_regexp(x,rules)
    expr = rule2regexp(rules(x),rules);
end