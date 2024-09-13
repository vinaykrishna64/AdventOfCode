S = readlines("input.txt");
f = x -> parse.(Int64,x)
S = f.(S[1])

using Printf
using ProgressBars

function PL(i,j,S)
    return digits((((i+10)*j)+S)*(i+10))[3] - 5;
end
function filldata(S,l =3)
    M = zeros(300,300)
    for idx in 1:300
        for jdx in 1:300
            M[idx,jdx] = PL(idx,jdx,S)
        end
    end
    MaxPL = -100000
    I = 0
    J = 0
    for idx in 1:(300-l+1)
        for jdx in 1:(300-l+1)
            x = sum(M[idx:idx+(l-1),jdx:jdx+(l-1)]);
            if x > MaxPL
                MaxPL = x
                I,J = idx,jdx
            end
        end
    end
    return I,J,MaxPL
end
I,J,_ = filldata(S);
@printf("part 1 = %d,%d\n",I,J)

function testAllSizes(S)
    P_final = -100000
    I_final = 0; J_final = 0; S_final = 0;
    sz = 0
    for iter in ProgressBar(1:300)
        sz += 1
        I,J,MaxPL = filldata(S,sz)
        if P_final < MaxPL
            I_final = I
            J_final = J
            P_final = MaxPL
            S_final = sz
        end
    end
    return I_final,J_final,P_final,S_final
end
I_final,J_final,P_final,S_final = testAllSizes(S)
@printf("part 2 = %d,%d,%d\n",I_final,J_final,S_final)





