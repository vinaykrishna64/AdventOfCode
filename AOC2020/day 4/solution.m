clear all
filename = 'input.txt';
S = readlines(filename);


p_no = 1;
i = 1;
while i <= numel(S)
    s = S(i);
    if ~strcmp(s,'')
        s = s.replace(":"," ").split(' ');
        for j = 1:numel(s)/2
            passports(p_no).(s(2*(j-1)+1)) = s(2*j);
        end
    else
        p_no = p_no + 1;
    end
    i = i + 1;
end


passports_1 = rmfield(passports,'cid');
fields = fieldnames(passports_1);

for p = 1:p_no
    p11 = 1;
    p22 = zeros(1,7);
    for i = 1:numel(fields)
        p11 = p11 .* isstring(passports_1(p).(fields{i}));
        if isstring(passports_1(p).(fields{i}))
            p22(i) = check_field(passports_1(p).(fields{i}),fields{i});
        end
    end
    p1(p) = p11;
    p2(p) = sum(p22) == 7;
end


disp(sprintf('part_1 = %d',sum(p1)))
disp(sprintf('part_2 = %d',sum(p2)))


function [out] = check_field(val,fld)
    out = 1;
    lst = ['a':'f' '0' '1' '2' '3'...
        '4' '5' '6' '7' '8' '9'];
    lst2 = ['0' '1' '2' '3'...
        '4' '5' '6' '7' '8' '9'];
    ecl = {"amb" "blu" "brn" "gry" "grn" "hzl" "oth"};
    if fld == "byr"
        val = str2double(val);
        if val < 1920 | val > 2002
            out = 0;
        end
    elseif fld == "iyr"
        val = str2double(val);
        if val < 2010 | val > 2020
            out = 0;
        end
    elseif fld == "eyr"
        val = str2double(val);
        if val < 2020 | val > 2030
            out = 0;
        end
    elseif fld == "hgt"
        val = char(val);
        h = str2double(string(val(1:end-2)));
        if val(end-1:end) == 'cm'
            if h < 150 | h > 193
                out = 0;
            end
        elseif val(end-1:end) == 'in'
           if h < 59 | h > 76
                out = 0;
           end 
        else
            out = 0;
        end
    elseif fld == "hcl"
        val = char(val);
        if numel(val) ~= 7
            out = 0;
        elseif val(1) ~= '#'
            out = 0;
        elseif sum(val(2:end) == lst','all') ~= 6
            out = 0;
        end
    elseif fld == "ecl"
        chk = cellfun(@(x)x == val,ecl);
        if sum(chk) ~= 1
            out = 0;
        end
    elseif fld == "pid"
        val = char(val);
        if numel(val) ~= 9
            out = 0;
        elseif sum(val == lst2','all') ~= 9
             out = 0;
        end
    end
    
end