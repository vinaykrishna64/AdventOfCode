S = readlines("input.txt");
pots = replace.(S[1],"initial state: " => "");
rules = split.(S[3:end]," => ");
using Printf
using ProgressBars

function checkrules(rules,spot)
    for idx in 1:length(rules)
        if rules[idx][1] == spot
            return rules[idx][2]
        end
    end
    return "."
end
function nextpot(pots,iters)
    plants = []
    for jdx in 1:iters
        pots = "...."*pots*"...."
        newPots = ""
        for idx in 3:length(pots)-3
            newPots *= checkrules(rules,pots[idx-2:idx+2]);
        end
        pots = newPots
        push!(plants,sum(collect(findall(==('#'),pots)).-1 .- jdx*2))
    end
    return plants
end

plants = nextpot(pots,1000)

@printf("part 1 = %d\n",plants[20])
using Plots
plot(1:1000,plants)
m = (plants[1000] - plants[999])
f = x -> m*(x - 1000) + plants[1000];

@printf("part 2 = %d\n",f(50000000000))




