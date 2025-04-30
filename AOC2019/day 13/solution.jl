S = readlines("input.txt");
S = split(S[1],",");
S = parse.(Int64,S);
for fluff in 1:1000
    push!(S,0)
end
S = Dict{Int, Int}(zip(0:length(S)-1, S))


function runProg(S,inp = 1,rel_base = 0)
    trk = 0; 
    outp = [];
    while true
        X = digits(S[trk])
        if length(X) < 2
            push!(X,0)
            push!(X,0)
            push!(X,0)
            push!(X,0)
        elseif length(X) < 3
            push!(X,0)
            push!(X,0)
            push!(X,0)
        elseif length(X) < 4
            push!(X,0)
            push!(X,0)
        elseif length(X) < 5
            push!(X,0)
        end
        opcode = X[1] + 10*X[2]
        if opcode == 1
            a = (X[3] == 2) ? S[S[trk+1]+rel_base] : ((X[3] == 1) ? S[trk+1] : S[S[trk+1]]);
            b = (X[4] == 2) ? S[S[trk+2]+rel_base] : ((X[4] == 1) ? S[trk+2] : S[S[trk+2]]);
            if X[5] == 2
                S[S[trk+3]+rel_base] = a+b;
            elseif X[5] == 1
                S[trk+3] = a+b;
            else
                S[S[trk+3]] = a+b;
            end
            trk += 4;
        elseif opcode == 2
            a = (X[3] == 2) ? S[S[trk+1]+rel_base] : ((X[3] == 1) ? S[trk+1] : S[S[trk+1]]);
            b = (X[4] == 2) ? S[S[trk+2]+rel_base] : ((X[4] == 1) ? S[trk+2] : S[S[trk+2]]);
            if X[5] == 2
                S[S[trk+3]+rel_base] = a*b;
            elseif X[5] == 1
                S[trk+3] = a+b;
            else
                S[S[trk+3]] = a*b;
            end
            trk += 4;
        elseif opcode == 3
            if X[3] == 2
                S[S[trk+1]+rel_base] = inp;
            elseif X[3] == 1
                S[trk+1] = inp;
            else
                S[S[trk+1]] = inp;
            end
            trk += 2;
        elseif opcode == 4
            if X[3] == 2
                a = S[S[trk+1]+rel_base];
            elseif X[3] == 1
                a = S[trk+1];
            else
                a = S[S[trk+1]];
            end
            push!(outp,a);
            trk += 2;
        elseif opcode == 5
            a = (X[3] == 2) ? S[S[trk+1]+rel_base] : ((X[3] == 1) ? S[trk+1] : S[S[trk+1]]);
            b = (X[4] == 2) ? S[S[trk+2]+rel_base] : ((X[4] == 1) ? S[trk+2] : S[S[trk+2]]);
            if a != 0
                trk = b;
            else
                trk += 3;
            end 
        elseif opcode == 6
            a = (X[3] == 2) ? S[S[trk+1]+rel_base] : ((X[3] == 1) ? S[trk+1] : S[S[trk+1]]);
            b = (X[4] == 2) ? S[S[trk+2]+rel_base] : ((X[4] == 1) ? S[trk+2] : S[S[trk+2]]);
            if a == 0
                trk = b;
            else
                trk += 3;
            end
        elseif opcode == 7
            a = (X[3] == 2) ? S[S[trk+1]+rel_base] : ((X[3] == 1) ? S[trk+1] : S[S[trk+1]]);
            b = (X[4] == 2) ? S[S[trk+2]+rel_base] : ((X[4] == 1) ? S[trk+2] : S[S[trk+2]]);
            if X[5] == 2
                if a < b
                    S[S[trk+3]+rel_base] = 1;
                else
                    S[S[trk+3]+rel_base] = 0;
                end
            else
                if a < b
                    S[S[trk+3]] = 1;
                else
                    S[S[trk+3]] = 0;
                end
            end
            trk += 4;
        elseif opcode == 8
            a = (X[3] == 2) ? S[S[trk+1]+rel_base] : ((X[3] == 1) ? S[trk+1] : S[S[trk+1]]);
            b = (X[4] == 2) ? S[S[trk+2]+rel_base] : ((X[4] == 1) ? S[trk+2] : S[S[trk+2]]);
            if X[5] == 2
                if a == b
                    S[S[trk+3]+rel_base] = 1;
                else
                    S[S[trk+3]+rel_base] = 0;
                end
            else
                if a == b
                    S[S[trk+3]] = 1;
                else
                    S[S[trk+3]] = 0;
                end
            end
            trk += 4;
        elseif opcode == 9
            rel_base += (X[3] == 2) ? S[S[trk+1]+rel_base] : ((X[3] == 1) ? S[trk+1] : S[S[trk+1]]);
            trk += 2;
        elseif opcode == 99
            break
        else
            error("Invalid opcode")
        end
    end
    return outp
end



function runProgPlay(S,inp = 1,rel_base = 0)
    trk = 0; 
    out_count = 0
    current_pos = []
    paddle = []
    ball = []
    score = []
    outp = [];
    while true
        X = digits(S[trk])
        if length(X) < 2
            push!(X,0)
            push!(X,0)
            push!(X,0)
            push!(X,0)
        elseif length(X) < 3
            push!(X,0)
            push!(X,0)
            push!(X,0)
        elseif length(X) < 4
            push!(X,0)
            push!(X,0)
        elseif length(X) < 5
            push!(X,0)
        end
        opcode = X[1] + 10*X[2]
        if opcode == 1
            a = (X[3] == 2) ? S[S[trk+1]+rel_base] : ((X[3] == 1) ? S[trk+1] : S[S[trk+1]]);
            b = (X[4] == 2) ? S[S[trk+2]+rel_base] : ((X[4] == 1) ? S[trk+2] : S[S[trk+2]]);
            if X[5] == 2
                S[S[trk+3]+rel_base] = a+b;
            elseif X[5] == 1
                S[trk+3] = a+b;
            else
                S[S[trk+3]] = a+b;
            end
            trk += 4;
        elseif opcode == 2
            a = (X[3] == 2) ? S[S[trk+1]+rel_base] : ((X[3] == 1) ? S[trk+1] : S[S[trk+1]]);
            b = (X[4] == 2) ? S[S[trk+2]+rel_base] : ((X[4] == 1) ? S[trk+2] : S[S[trk+2]]);
            if X[5] == 2
                S[S[trk+3]+rel_base] = a*b;
            elseif X[5] == 1
                S[trk+3] = a+b;
            else
                S[S[trk+3]] = a*b;
            end
            trk += 4;
        elseif opcode == 3
            if (ball == []) | (paddle ==[])
                inp = 0
            elseif ball < paddle
                inp = 1
            elseif ball > paddle
                inp = -1
            else 
                inp = 0
            end
            if X[3] == 2
                S[S[trk+1]+rel_base] = inp;
            elseif X[3] == 1
                S[trk+1] = inp;
            else
                S[S[trk+1]] = inp;
            end
            trk += 2;
        elseif opcode == 4
            if X[3] == 2
                a = S[S[trk+1]+rel_base];
            elseif X[3] == 1
                a = S[trk+1];
            else
                a = S[S[trk+1]];
            end
            push!(outp,a);
            out_count += 1
            trk += 2;
            if out_count%3 == 0
                if a == 3
                    ball = current_pos[1]
                elseif a == 4
                    paddle = current_pos[1]
                elseif all(current_pos .== [-1,0])
                    score = a
                end
                current_pos = [];
            else
                push!(current_pos,a)
            end
        elseif opcode == 5
            a = (X[3] == 2) ? S[S[trk+1]+rel_base] : ((X[3] == 1) ? S[trk+1] : S[S[trk+1]]);
            b = (X[4] == 2) ? S[S[trk+2]+rel_base] : ((X[4] == 1) ? S[trk+2] : S[S[trk+2]]);
            if a != 0
                trk = b;
            else
                trk += 3;
            end 
        elseif opcode == 6
            a = (X[3] == 2) ? S[S[trk+1]+rel_base] : ((X[3] == 1) ? S[trk+1] : S[S[trk+1]]);
            b = (X[4] == 2) ? S[S[trk+2]+rel_base] : ((X[4] == 1) ? S[trk+2] : S[S[trk+2]]);
            if a == 0
                trk = b;
            else
                trk += 3;
            end
        elseif opcode == 7
            a = (X[3] == 2) ? S[S[trk+1]+rel_base] : ((X[3] == 1) ? S[trk+1] : S[S[trk+1]]);
            b = (X[4] == 2) ? S[S[trk+2]+rel_base] : ((X[4] == 1) ? S[trk+2] : S[S[trk+2]]);
            if X[5] == 2
                if a < b
                    S[S[trk+3]+rel_base] = 1;
                else
                    S[S[trk+3]+rel_base] = 0;
                end
            else
                if a < b
                    S[S[trk+3]] = 1;
                else
                    S[S[trk+3]] = 0;
                end
            end
            trk += 4;
        elseif opcode == 8
            a = (X[3] == 2) ? S[S[trk+1]+rel_base] : ((X[3] == 1) ? S[trk+1] : S[S[trk+1]]);
            b = (X[4] == 2) ? S[S[trk+2]+rel_base] : ((X[4] == 1) ? S[trk+2] : S[S[trk+2]]);
            if X[5] == 2
                if a == b
                    S[S[trk+3]+rel_base] = 1;
                else
                    S[S[trk+3]+rel_base] = 0;
                end
            else
                if a == b
                    S[S[trk+3]] = 1;
                else
                    S[S[trk+3]] = 0;
                end
            end
            trk += 4;
        elseif opcode == 9
            rel_base += (X[3] == 2) ? S[S[trk+1]+rel_base] : ((X[3] == 1) ? S[trk+1] : S[S[trk+1]]);
            trk += 2;
        elseif opcode == 99
            break
        else
            error("Invalid opcode")
        end
    end
    return score
end

function simulateRobot(S)
    sequence = runProg(copy(S),0)
    paintedPixels = Dict()
    pos= []
    count = 0
    for idx in 1:length(sequence)
        if idx%3 == 1
            push!(pos,sequence[idx])
        elseif idx%3 == 2
            push!(pos,sequence[idx])
        else
            paintedPixels[pos] = sequence[idx]
            pos= []
            if sequence[idx] == 2
                count += 1
            end
        end
    end
    print("part 1 : ")
    println(count)

    S_coin = copy(S)
    S_coin[0] = 2;
    score = runProgPlay(S_coin,0)
    print("part 2 : ")
    println(score)
    # K = collect(keys(paintedPixels))
    # println(K)
    # for row in -1:6
    #     for col in -1:45
    #         if haskey(paintedPixels,[col,row])
    #             if paintedPixels[[col,row]] == 1
    #                 print("#")
    #             else
    #                 print(" ")
    #             end
    #         else
    #             print(" ")
    #         end
    #     end
    #     print("\n")
    # end
end
simulateRobot(S)