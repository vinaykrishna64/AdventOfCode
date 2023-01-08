clear all
clc

S = str2double(readlines("input.txt"));

%% part 1
S = S/10;
for i = 1:100
    P = primes(i);
    N = prod([6 5 P]); % 6 is the magic number from the graph 
    % every 6th house is local maixma and then 60/ 120 so on
    if sum(divisors(N)) >= S 
        n = N;
        break
    end
end

for i = n:-30:floor(n/2) % can be a bit more condifent i.e check just close
                         % going till half i.e removing 2 factor is robust
    if sum(divisors(i)) >= S 
        n = i;
    end
end

part_1 = n
   

%% part 2


for i = 1:100
    P = primes(i);
    N = prod([6 5 P]); % 6 is the magic number from the graph 
    D = divisors(N);
    d = D(flip(D <= 50));
    % every 6th house is local maixma and then 60/ 120 so on
    if sum(d)*11 >= S 
        n = N;
        break
    end
end


for i = n:-30:floor(n/2) % can be a bit more condifent i.e check just close
                         % going till half i.e removing 2 factor is robust
    D = divisors(i);
    d = D(flip(D <= 50));
    if sum(d)*11 >= S 
        n = i;
    end
end
part_2 = n