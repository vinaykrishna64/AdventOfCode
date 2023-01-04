clear all
clc
S = readlines("input.txt");
data = struct();
operations = struct();
for i = 1:numel(S)
    s = S(i).split(" ");
    name = s(1).replace([":"],[""]);
    if numel(s) == 2 %it's a number
        data.(name) = str2double(s(2));
    else %operations
        operations.(name) = s(2:end).split(" ");
    end
end
data2 = data;
operations2 = operations;

data =  solve_shouts(data,operations);

fprintf('part 1 =  %14d \n',data.root);



%% part 2
data = data2;
operations = operations2;
operations.root(2) = "-";
syms x
data.humn = 'x';
data =  solve_shouts(data,operations);
part_2 = solve(data.root);
fprintf('part 2 =  %14d \n',part_2);
%%
function [data] =  solve_shouts(data,operations)
    syms x
    while ~isfield(data,"root")
        flds = fieldnames(operations);
        for i = 1:numel(flds)
            temp = operations.(flds{i});
            if isfield(data,temp(1)) & isfield(data,temp(3))
                rp1 = strcat('(',string(data.(temp(1))),')');
                rp2 = strcat('(',string(data.(temp(3))),')');
                data.(flds{i}) = eval(strjoin(operations.(flds{i})).replace([temp(1),temp(3)],[rp1,rp2]));
                operations = rmfield(operations,flds{i});
            end
        end
    end
end

