inp = readlines("input.txt");
using Printf
using ProgressBars

function picknew(S,Recipes)
    for idx in 1:2
        new = S[idx] + (Recipes[S[idx]]+1)
        if  new <= length(Recipes)
            S[idx] = new
        else
            S[idx] = new%length(Recipes) == 0 ? length(Recipes) : new%length(Recipes)
        end
    end
    return S
end
function churn(inp)
    S = [1,2];
    Recipes = [3,7];
    N = parse(Int64,inp)
    part1 = true
    part2 = true
    last = 1
    while part1 | part2
        score = sum(Recipes[S]);
        for digit in reverse(digits(score))
            push!(Recipes,digit)
        end
        S = picknew(S,Recipes)  
        if part2 & (length(Recipes) >= 7)
            if occursin(inp,join(string.(Recipes[last:end])))
                X = findfirst(inp,join(string.(Recipes)))
                @printf("part 2 = %d\n",X[1]-1) 
                part2 = false
            else
                last = length(Recipes)-4
            end
        end
        if part1
            if length(Recipes) >= N+10
                @printf("part 1 = %s\n",join(string.(Recipes[N+1:N+10])))    
                part1 = false
            end
        end
    end
    return 
end
churn(inp[1])

