clc
clear all

fid = fopen('day3.txt');

%% prob 1

n = 1;
while n <= 1000
 line_ex = fgetl(fid);  
 x(n,:)= convert(line_ex);
 n = n + 1;
end

for i = 1:12
    oneN(i) = sum(x(:,i) == 1);
    zeroN(i) = sum(x(:,i) == 0);
    if oneN(i) > zeroN(i)
        gamma(i) = 1;
        eps(i) = 0;
    else
        gamma(i) = 0;
        eps(i) = 1;
    end
end

G = binaryVectorToDecimal(gamma);
E = binaryVectorToDecimal(eps);
ans1 = G*E;

%% prob 2
I = 1:1000;
for i = 1:12
    if sum(x(I,i) == 1 )  >= sum(x(I,i) == 0) 
        In = find( x(I,i) == 1);
        I = I(In);
    else
        In = find( x(I,i) == 0);
        I = I(In);
    end
    if length(I) == 1
        break
    end
end
O2 = binaryVectorToDecimal(x(I,:));

I = 1:1000;
for i = 1:11 
    if sum(x(I,i) == 1 )  < sum(x(I,i) == 0) 
        In = find( x(I,i) == 1);
        I = I(In);
    else 
        In = find( x(I,i) == 0);
        I = I(In);
    end
    if length(I) == 1
        break
    end
end
CO2 = binaryVectorToDecimal(x(I,:));
ans2 = CO2 * O2

%% str to array
function [x] = convert(bin_str)
    for i = 1:length(bin_str)
        x(i) = str2num(bin_str(i));
    end
end