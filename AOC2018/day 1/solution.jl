S = readlines("input.txt");
S = parse.(Int64, S);
p1 = sum(S);
println("part 1 = $p1")
fq = S[1];
fqs = [fq];
circshift!(S, -1)
while true
    global fq = fq  + S[1];
    if in(fq,fqs)
        println("part 1 = $fq")
        break
    else
        push!(fqs,fq)
        circshift!(S, -1)
    end
end
