clear all
filename            = 'input.txt';
S                   = readlines(filename);
instr = str2double(S(1).replace(["L","R"],["1","2"]).split('')); instr = instr(2:end-1);
network = S(3:end);
P = strtrim(network.extractBefore('='));
PL = strtrim(network.extractBetween('(',','));
PR = strtrim(network.extractBetween(',',')'));

dL = dictionary(P,PL); dR = dictionary(P,PR);

%% part 1
fprintf('part_1 = %10d\n',path_cycle("AAA","ZZZ",dL,dR,instr,1))
%% part 2
p       = P.split('');
S_node  = strcmp(p(:,4),"A"); Starts = P(find(S_node == 1));
E_node  = strcmp(p(:,4),"Z"); Ends = P(find(E_node == 1));

for idx = 1:numel(Starts)
    C(idx) = diff(path_cycle(Starts(idx),Ends,dL,dR,instr,2));
end
% find GCD 
g = C(1);
for i=2:numel(C)
    g = gcd(g,C(i));
end
C = C/g;
fprintf('part_2 = %10d\n',prod(C)*g) % GCD time LCM

%% functions 
function [out] = path_cycle(pos,Endsat,dL,dR,instr,n_cycl)
    flg = 1;
    cycl = 0;
    out = [];
    while true
        if instr(1) == 1
            pos = dL(pos);
        else
            pos = dR(pos);
        end
        if any(strcmp(pos, Endsat))
            cycl = cycl +1;
            out = [out;flg];
            if cycl == n_cycl
                break
            end
        end
        flg = flg + 1;
        instr = circshift(instr,-1);
    end
end