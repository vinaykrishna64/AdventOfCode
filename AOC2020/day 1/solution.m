clear all
filename = 'input.txt';
S = str2double(readlines(filename));
for i = 1:200
    for j = i+1:200
        if S(i)+S(j) == 2020
            disp(sprintf('part_1 = %d',S(i)*S(j)))
        end
        for k = j+1:200
            if S(i)+S(j)+S(k) == 2020
                disp(sprintf('part_2 = %d',S(i)*S(j)*S(k)))
            end
        end
    end
end