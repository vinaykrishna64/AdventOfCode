S = readlines("input.txt");
S = split(S[1],"-");
S = parse.(Int64,S);
passwds = S[1]:S[2]


function isValidpass(x)
    X = diff(reverse(digits(x)))
    if any(X .==0) && all( X .>= 0 )
        return 1
    end
    return 0
end
using Printf
@printf("part 1 = %d\n",sum(isValidpass.(passwds)))


function isValidpassp2(x)
    X = diff(reverse(digits(x)))
    if any(X .==0) && all( X .>= 0 )
        X = reverse(digits(x))
        diffidx = findall(x->x!=0, X[1:5] .!= X[2:6])
        circshift!(push!(diffidx,0),1)
        push!(diffidx,6) 
        if any(diff(diffidx) .== 2) 
            return 1
        end
    end
    return 0
end


@printf("part 2 = %d\n",sum(isValidpassp2.(passwds)))