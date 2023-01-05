clear all
clc

S = str2vec(readlines("input.txt"));
S1 = S;
for i = 1:50
    S1 = convert(S1);
    N(i) = numel(S1);
end
part_1 = N(40)
part_2 = N(50)

Nd = gradient(N);
figure("WindowState","maximized")
plot(1:49, Nd(1:end-1)./N(1:end-1),'b-o')
title("finding equillibrium")
legend({"$\frac{N_{i} - N_{i-1}}{N_{i-1}}$"},'interpreter','latex','fontsize',16)
exportgraphics(gcf,'finding_equillibrium.jpeg','Resolution',1200)


function [S2] = convert(S)
    S2 = [];
    n = 1;
    track = S(1);
    for i = 2:numel(S)
        if S(i) == track
            n = n+1;
        else
            S2 = [S2 n track];
            n = 1;
            track = S(i);
        end
    end
    if n
        S2 = [S2 n track];
    end
end

function [sg] = str2vec(SG)
    sg = str2double(string(char(SG)'))';
end