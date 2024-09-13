S = readlines("input.txt");
S = replace.(S,"position=<" => "");
S = replace.(S,"> velocity=<" => ",");
S = replace.(S,">" => "");
S = split.(S,",");
f = x -> parse.(Int64,x)
S = f.(S)
M = zeros(length(S),4)
for i in 1:length(S)
    M[i,1:4] = S[i]
end
using Printf
using Plots
function iter_points(M,mode = 1)
    if mode == 1
        M[1:end,1] += M[1:end,3]
        M[1:end,2] += M[1:end,4]
    elseif mode == -1
        M[1:end,1] -= M[1:end,3]
        M[1:end,2] -= M[1:end,4]
    end
    return M,maximum(M[1:end,1]) + maximum(M[1:end,2]) - minimum(M[1:end,1]) - minimum(M[1:end,2])
end

function printim2console(M)
    X = Int.(M[1:end,1] .- (minimum(M[1:end,1]) - 1))
    Y = Int.(M[1:end,2] .- (minimum(M[1:end,2]) - 1))
    scatter(X,Y)
    final = Int.(zeros((maximum(Y),maximum(X))))
    for i in 1:length(X)
        final[Y[i],X[i]] = 1
    end
    imsize = size(final)
    inds = 1:imsize[2]
    f(x) = x==1 ? '*' : ' '
    println("<============part 1==============>")
    for idx in 1:imsize[1]
        println(join(f.(final[idx,1:end])))
    end
    println("<=================================>")
end

function movestars(S)
    S,old_L = iter_points(S,0)
    t = 0;
    while true
        ## iter move
        S,new_L = iter_points(S,1)
        if old_L < new_L
            S = iter_points(S,-1)[1]
            printim2console(S)
            return t
        else
            old_L = new_L
        end
        t += 1
    end
end
 @printf("part 2 = %d\n",movestars(M))







