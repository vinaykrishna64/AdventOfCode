clear all
clc
fileID = fopen("input.txt",'r');
S = textscan(fileID,"%s");
S = string(S{1});
S2 = S.replace(["\\",string('\"')],["a","a"]).erase(string('"'));
S3 = S.replace(["\",string('"')],["\\",string('\"')]);
N = 0;
N_s = 0;
N_s2 = 0;
for i = 1:numel(S2)
    s = split(S2(i),"\x");
    N_s = N_s + numel(char(S(i)));
    N_s2 = N_s2 + numel(char(S3(i)));
    if numel(s) == 1;
       N = N + numel(char(s));
    else
       N = N + sum(arrayfun(@(x) numel(char(x)) ,s)) - (numel(s) - 1);
    end
end

part_1 = N_s - N

part_2 = 2*numel(S) + N_s2 - N_s
