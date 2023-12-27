S = readlines("input.txt");
## part 1
function f(x,y) # counts reps of y in x
    s = 0;
    for n in 1:length(x)
        if y == x[n]
            s = s + 1;
        end
    end
    return s
end
function fn_check(Y,S,n) # see if any element reps n times
    for jdx in 1:size(Y)[1]
        if f(S,Y[jdx]) == n
            return true
        end
    end
    return false
end
n2 = 0;
n3 = 0;
for idx in 1:size(S)[1]
    Y = unique(S[idx]);
    if fn_check(Y,S[idx],2)
        global n2 = n2 + 1; # count wiht atleast one 2 rep
    end
    if fn_check(Y,S[idx],3)
        global n3 = n3 + 1; # count wiht atleast one 3 rep
    end
end
println("part 1 = $(n2 * n3)")

## part 2
function test_diff(x,y) # counts n different elements
    s = 0;
    for idx in 1:length(x)
        if x[idx] != y[idx]
            s = s + 1;
        end
    end
    if s == 1
        return true
    end
    return false
end
function test_same(x,y) # common elements
    s = [];
    for idx in 1:length(x)
        if x[idx] == y[idx]
            push!(s,x[idx])
        end
    end
    return join(s)
end
flg = 0;
for idx in 1:size(S)[1]
    for jdx in idx:size(S)[1]
        if test_diff(S[idx],S[jdx])
            print("part 1 = ",test_same(S[idx],S[jdx]))
            global flg = 1;
            break
        end
    end
    if flg == 1
        break
    end
end