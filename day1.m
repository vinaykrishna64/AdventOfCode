
x =  importdata('day1.txt');
sum(x(1:end-1)<x(2:end))

L = length(x);
for i = 1:L-2
    y(i) =sum( x(i:i+2));
end
sum(y(1:end-1)<y(2:end))