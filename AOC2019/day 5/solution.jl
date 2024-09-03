S = readlines("input.txt");
S = split(S[1],",");
S = parse.(Int64,S);
S = Dict{Int, Int}(zip(0:length(S)-1, S))

function runProg(S,inp = 1)
    trk = 0; 
    outp = 0;
    while true
        X = digits(S[trk])
        if length(X) < 2
            push!(X,0)
            push!(X,0)
            push!(X,0)
        elseif length(X) < 3
            push!(X,0)
            push!(X,0)
        elseif length(X) < 4
            push!(X,0)
        end
        opcode = X[1] + 10*X[2]
        if opcode == 1
            a = (X[3] == 1) ? S[trk+1] : S[S[trk+1]];
            b = (X[4] == 1) ? S[trk+2] : S[S[trk+2]];
            S[S[trk+3]] = a+b;
            trk += 4;
        elseif opcode == 2
            a = (X[3] == 1) ? S[trk+1] : S[S[trk+1]];
            b = (X[4] == 1) ? S[trk+2] : S[S[trk+2]];
            S[S[trk+3]] = a*b;
            trk += 4;
        elseif opcode == 3
            S[S[trk+1]] = inp;
            trk += 2;
        elseif opcode == 4
            a = (X[3] == 1) ? S[trk+1] : S[S[trk+1]];
            outp = a;
            trk += 2;
        elseif opcode == 99
            break
        else
            error("Invalid opcode")
        end
    end
    return outp
end
using Printf
@printf("part 1 = %d\n",runProg(copy(S)))

function runProg2(S,inp = 1)
    trk = 0; 
    outp = 0;
    while true
        X = digits(S[trk])
        if length(X) < 2
            push!(X,0)
            push!(X,0)
            push!(X,0)
        elseif length(X) < 3
            push!(X,0)
            push!(X,0)
        elseif length(X) < 4
            push!(X,0)
        end
        opcode = X[1] + 10*X[2]
        if opcode == 1
            a = (X[3] == 1) ? S[trk+1] : S[S[trk+1]];
            b = (X[4] == 1) ? S[trk+2] : S[S[trk+2]];
            S[S[trk+3]] = a+b;
            trk += 4;
        elseif opcode == 2
            a = (X[3] == 1) ? S[trk+1] : S[S[trk+1]];
            b = (X[4] == 1) ? S[trk+2] : S[S[trk+2]];
            S[S[trk+3]] = a*b;
            trk += 4;
        elseif opcode == 3
            S[S[trk+1]] = inp;
            trk += 2;
        elseif opcode == 4
            a = (X[3] == 1) ? S[trk+1] : S[S[trk+1]];
            outp = a;
            trk += 2;
        elseif opcode == 5
            a = (X[3] == 1) ? S[trk+1] : S[S[trk+1]];
            b = (X[4] == 1) ? S[trk+2] : S[S[trk+2]];
            if a != 0
                trk = b;
            else
                trk += 3;
            end 
        elseif opcode == 6
            a = (X[3] == 1) ? S[trk+1] : S[S[trk+1]];
            b = (X[4] == 1) ? S[trk+2] : S[S[trk+2]];
            if a == 0
                trk = b;
            else
                trk += 3;
            end
        elseif opcode == 7
            a = (X[3] == 1) ? S[trk+1] : S[S[trk+1]];
            b = (X[4] == 1) ? S[trk+2] : S[S[trk+2]];
            if a < b
                S[S[trk+3]] = 1;
            else
                S[S[trk+3]] = 0;
            end
            trk += 4;
        elseif opcode == 8
            a = (X[3] == 1) ? S[trk+1] : S[S[trk+1]];
            b = (X[4] == 1) ? S[trk+2] : S[S[trk+2]];
            if a == b
                S[S[trk+3]] = 1;
            else
                S[S[trk+3]] = 0;
            end
            trk += 4;
        elseif opcode == 99
            break
        else
            error("Invalid opcode")
        end
    end
    return outp
end
@printf("part 2 = %d\n",runProg2(copy(S),5))