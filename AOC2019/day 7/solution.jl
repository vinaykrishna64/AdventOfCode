S = readlines("input.txt");
S = split(S[1],",");
S = parse.(Int64,S);
S = Dict{Int, Int}(zip(0:length(S)-1, S))

function IntComp(S,inp = 1)
    trk = 0; 
    outp = 0;
    cinpidx = 1;
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
            S[S[trk+1]] = inp[cinpidx];
            cinpidx += 1
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

function run_phases(S,item)
    signal = 0
    for phs in item
        signal = IntComp(copy(S),[phs,signal]) 
    end
    return signal
end

using Combinatorics
function P1(S)
    p1 = 0
    for item in permutations(0:4)
        p1 = max(p1,run_phases(copy(S),item))
    end
    return p1
end
using Printf
@printf("part 1 = %d\n",P1(S))

##----------------------------------------------------------------------------

function IntCompPausable(S,inp ,cinpidx,trk)
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
            if cinpidx <= length(inp)
                S[S[trk+1]] = inp[cinpidx];
                cinpidx += 1
                trk += 2;
            else
                return outp,cinpidx,S,trk
            end
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
    return outp,cinpidx,S,0
end



function run_phases_feedback(S,item)
    inpts = [[],[],[],[],[]]
    cinpidx = [1,1,1,1,1]
    for idx in 1:5
        push!(inpts[idx],item[idx])
    end
    push!(inpts[1],0)
    progs = [copy(S),copy(S),copy(S),copy(S),copy(S)];
    state = [0,0,0,0,0]
    #state of running
    inp2out = [2,3,4,5,1]
    Ctrk = [0,0,0,0,0]
    signal = 0
    while true
        try
            for progidx in 1:5
                OutVal,CindVal,ProgOut,trkOut = IntCompPausable(progs[progidx],inpts[progidx],cinpidx[progidx],Ctrk[progidx])
                push!(inpts[inp2out[progidx]],OutVal)
                cinpidx[progidx] = CindVal
                progs[progidx] = ProgOut
                Ctrk[progidx] = trkOut
            end
            for progidx in 1:5
                if cinpidx[progidx] > length(inpts[progidx])+1
                    state[progidx] = 1
                else
                    state[progidx] = 0
                end
            end
            if any(state .== 1) | inpts[1][end] < signal
                break
            end
            signal = inpts[1][end]
        catch
            break
        end
    end
    return signal
end

function P2(S)
    p1 = 0
    for item in permutations(5:9)
        p1 = max(p1,run_phases_feedback(copy(S),item))
    end
    return p1
end

using Printf
@printf("part 2 = %d\n",P2(S))