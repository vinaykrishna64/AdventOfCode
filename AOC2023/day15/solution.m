clear all
filename            = 'input.txt';
S                   = readlines(filename);
S = S.split(',');

P1 = 0;
for idx = 1:numel(S)
    P1= P1 + hashmap(S(idx));
end

fprintf('part 1 = %14d \n',P1)

%% part 2
Box1 = cell(1,256); Box2 = cell(1,256);
val = cell(1,numel(S));
F = zeros(1,numel(S)); 
Loc = zeros(1,numel(S));
Type = zeros(1,numel(S));
for idx = 1:numel(S)
    s = S(idx);
    if contains(s,'=')
        val{idx} = s.extractBefore('=');
        F(idx) =  str2double(s.extractAfter('=')); 
        Type(idx) = 1;
    else
       val{idx} = s.extractBefore('-');
    end
    Loc(idx) = hashmap(val{idx})+1;
end

for idx = 1:numel(S)
    if Type(idx)
        if numel(Box1{Loc(idx)})
            I = find(Box1{Loc(idx)} == val{idx});
            if ~numel(I)
                Box1{Loc(idx)} = [Box1{Loc(idx)}; val{idx}];
                Box2{Loc(idx)} = [Box2{Loc(idx)}; F(idx)];
            else
                I = find(Box1{Loc(idx)} == val{idx});
                Box2{Loc(idx)}(I) = F(idx);
            end
        else
            if size(Box1{Loc(idx)},2) == 0
                Box1{Loc(idx)} = [ val{idx}];
                Box2{Loc(idx)} = [ F(idx)];
            else
                Box1{Loc(idx)} = [Box1{Loc(idx)}; val{idx}];
                Box2{Loc(idx)} = [Box2{Loc(idx)}; F(idx)];
            end
        end
    else
        if numel(Box1{Loc(idx)})
            I = find(Box1{Loc(idx)} == val{idx});
            if I
                Box1{Loc(idx)}(I) = [];
                Box2{Loc(idx)}(I) = [];
            end
        end
    end
end
P2 = 0;
for idx = 1:numel(Box2)
    if numel(Box2{idx})
        P2 =  P2 +sum(idx*[1:numel(Box2{idx})]' .* Box2{idx});
    end
end
fprintf('part 2 = %14d \n',P2)
%%

function [val] = hashmap(S)
    ops = @(x,v)  mod((v+x)*17,256);
    s = double(char(S));
    val = 0;
    for jdx = 1:numel(s)
        val = ops(s(jdx),val);
    end
end