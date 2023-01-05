clear all
clc

S = readlines("input.txt").replace(["j","i"],["J","I"]);

% get all wires
[wires,flg] = get_wires(S);
wires = unique(wires);
M = containers.Map(wires,1:numel(wires));
signal = repmat("",size(wires));
%% part 1
signal = solve_wires(signal,flg,M,S);
part_1 = bin2dec(signal(M("a")))
%% part 2
signal = repmat("",size(wires));
signal(M("b")) = dec2bin(part_1,16);
signal = solve_wires(signal,flg,M,S);
part_2 = bin2dec(signal(M("a")))
%% functions
function [signal] = solve_wires(signal,flg,M,S)
    while sum(strcmp(signal,""))
        for i = 1:numel(S)
            s = S(i).split(" ");
            if flg(i) == 5
                if signal(M(s(end))) == ""
                    signal(M(s(end))) = dec2bin(str2double(s(1)),16);
                    flg(i) = 0;
                end
            elseif flg(i) == 4
                if signal(M(s(1))) ~= ""
                    signal(M(s(end))) = signal(M(s(1)));
                    flg(i) = 0;
                end
            elseif flg(i) == 1
                if signal(M(s(2))) ~= ""
                    sg = str2vec(signal(M(s(2))));
                    signal(M(s(end))) = vec2str(1- sg);
                    flg(i) = 0;
                end
            elseif flg(i) == 3
                if signal(M(s(1))) ~= ""
                    sg = str2vec(signal(M(s(1))));
                    if contains(S(i),"LSHIFT")
                        sg = circshift(sg,-str2double(s(3)));
                        sg(end) = 0;
                    else
                        sg = circshift(sg,str2double(s(3)));
                        sg(1) = 0;
                    end
                    signal(M(s(end))) = vec2str(sg) ;
                    flg(i) = 0;
                end
            elseif flg(i) == 2
                w = [s(1:2:3)];
                is_num = ~isnan(str2double(w));
                if all(~is_num)
                    if signal(M(s(1))) ~= "" &  signal(M(s(3))) ~= ""
                        sg1 = str2vec(signal(M(s(1))));
                        sg2 = str2vec(signal(M(s(3))));
                        if contains(S(i),"AND")
                            sg = sg1 & sg2;
                        else
                            sg = sg1 | sg2;
                        end
                        signal(M(s(end))) = vec2str(double(sg)) ;
                        flg(i) = 0;
                    end
                else
                    if signal(M(w(~is_num))) ~= "" 
                        sg1 = str2vec(signal(M(w(~is_num))));
                        sg2 = str2vec(dec2bin(str2double(w(is_num)),16));
                        if contains(S(i),"AND")
                            sg = sg1 & sg2;
                        else
                            sg = sg1 | sg2;
                        end
                        signal(M(s(end))) = vec2str(double(sg)) ;
                        flg(i) = 0;
                    end
                end
            end
        end 
    end
end
function [wires,flg] = get_wires(S)
    wires = [];
    flg = zeros(size(S));
    for i = 1:numel(S)
        s = S(i).split(" ");
        if contains(S(i),"NOT")
            w = [s(2) s(end)];
            w = w(isnan(str2double(w)));
            if ~iscolumn(w)
                w = w';
            end
            wires = [wires; w];
            flg(i) = 1;
        elseif contains(S(i),"OR") | contains(S(i),"AND")
            w = s(1:2:end);
            w = w(isnan(str2double(w)));
            if ~iscolumn(w)
                w = w';
            end
            wires = [wires; w];
            flg(i) = 2;
        elseif contains(S(i),"LSHIFT") | contains(S(i),"RSHIFT")
            w = [s(1) s(end)];
            w = w(isnan(str2double(w)));
            if ~iscolumn(w)
                w = w';
            end
            wires = [wires; w];
            flg(i) = 3;
        else
            wires = [wires; s(end)];
            if isnan(str2double(s(1)))
                wires = [wires; s(1)];
                flg(i) = 4;
            else
                flg(i) = 5;
            end
        end
    end
end
function [sg] = str2vec(SG)
    sg = str2double(string(char(SG)'))';
end
function [SG] = vec2str(sg)
    SG = strjoin(string(sg),"");
end