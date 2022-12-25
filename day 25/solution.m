clear all
clc

S = readlines("input.txt").replace(["2","1","0","-","="],[",2,",",1,",",0,",",-1,",",-2,"]).replace([",,"],[","]);

inp_dec = 0;
for i = 1:numel(S)
    s = str2double(S(i).split(","));
    s = s(2:end-1)';
    inp_dec = inp_dec + snafu2dec(s);% snafu to decimal
end

% decimal to snafu
place = dec2snafu(inp_dec);
place = strjoin(string(flip(place)).replace(string([2:-1:-2]),["2","1","0","-","="]),'');
part_1 = place

%% functions
function [dec] = snafu2dec(inp_snafu)
    dec = sum(5.^[0:numel(inp_snafu)-1] .* flip(inp_snafu));
end
function [place] = dec2snafu(inp_dec)
    powers = 5.^(25:-1:0);
    place = zeros(size(powers));
    for i = 1:numel(powers)
        place(i) = floor(inp_dec/powers(i));
        inp_dec = mod(inp_dec,powers(i));
    end
    place = flip(place);
    while any(place > 3)
        for i = 1:numel(place)
            if place(i) == 3
                place(i) = -2;
                place(i+1) = place(i+1)+1;
            elseif place(i) == 4
                place(i) = -1;
                place(i+1) = place(i+1)+1;
            elseif place(i) == 5
                place(i) = 0;
                place(i+1) = place(i+1)+1;
            end
        end
    end
end