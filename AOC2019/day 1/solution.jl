S = readlines("input.txt");
S = parse.(Int64, S);

function fuel_cal(x)
    return floor(x/3) - 2
end

p1 = sum(fuel_cal.(S));
using Printf
@printf("part 1 = %d\n",p1)

function fuel_recur(x,cumfuel = 0)
    f = fuel_cal(x)
    if f<= 0
        return cumfuel
    else
        return fuel_recur(f,cumfuel+f)
    end
end

p2 = sum(fuel_recur.(S));
@printf("part 2 = %d\n",p2)