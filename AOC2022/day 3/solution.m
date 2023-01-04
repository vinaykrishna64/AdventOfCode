clear all
clc
S = readlines('input.txt');
M = containers.Map(string(['a':'z' 'A':'Z']'),1:52);
C = arrayfun(@commons ,S,'UniformOutput',false); %commons
Priority = cellfun(@(x) sum(arrayfun(@(y)M(string(y)),x)),C);

sum(Priority) %part 1

C2 = arrayfun(@commons2 ,S(1:3:end-2),S(2:3:end-1),S(3:3:end));
Priority2 = arrayfun(@(x) M(string(x)),C2);

sum(Priority2) %part 2

function [out] = commons(s)
s = s.char();
out = intersect(s(1:(numel(s)/2)),s(((numel(s)/2)+1):end));
end

function [out] = commons2(A,B,C)

out = intersect(intersect(A.char(),B.char()),C.char());
end
