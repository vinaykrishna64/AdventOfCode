clear all
filename    = 'input.txt';
S           = readlines(filename);
S           = S.split('');
Sstars      = str2double(S(:,2:end-1).replace('*','100')); % storing stars separately for part 2
S           = str2double(S(:,2:end-1).replace('.','10')); % set .'s to 10
symbols     = double(isnan(S));
S(isnan(S)) = 11; % set symbols to 11
S = padarray(S,[1 1],0,'both'); % Input changed to digits + 10 & 11 for empty and symbol respectively
symbols = padarray(symbols,[1 1],0,'both'); % array consisting of symbol flags 
%% part 1
[parts,part_address] = find_parts(S,symbols);
fprintf('Part 1 = %d\n',sum(parts))
%% part 2
Sstars =  padarray(Sstars,[1 1],0,'both');
stars       = find(Sstars >= 100);
part_address(stars) = -[1:numel(stars)];
G_rats = Gears(part_address,parts);
fprintf('Part 2 = %d\n',sum(G_rats))
%% functions
function [G_rats] = Gears(S,parts)
    G_rats = [];
    for idx = 2:size(S,1)-1
        for jdx = 2:size(S,2)-1
            if S(idx,jdx) < 0
                sub_mat = S(idx-1:idx+1,jdx-1:jdx+1);
                sub_mat = sub_mat(sub_mat>0);
                Uadd = unique(sub_mat);
                if numel(Uadd) == 2 % if exactly two part nums get gear ratio and save
                    G_rats = [G_rats; prod(parts(Uadd))];
                end
            end
        end
    end
end
function [part_no,part_address] = find_parts(S,symbols)
    part_no  = [];
    part_address = zeros(size(S));
    for idx = 2:size(S,1)-1 
        startPt = 0; endPt = 0; %marks for flagging part numbers
        for jdx = 2:size(S,2)-1 
            if startPt == 0 & S(idx,jdx) < 10 % mark start point
                startPt = jdx;
            end
            if startPt ~= 0 % mark end point
                if S(idx,jdx) < 10
                    endPt = jdx;
                end
                if jdx == size(S,2)-1 | S(idx,jdx) >= 10 % end is reached
                    isPart = 0;
                    % check rows
                    isPart = sum(symbols(idx+1,startPt:endPt));
                    isPart = isPart + sum(symbols(idx-1,startPt:endPt));
                    % check columns
                    isPart = isPart + sum(symbols(idx-1:idx+1,endPt+1));
                    isPart = isPart + sum(symbols(idx-1:idx+1,startPt-1));
                    if isPart
                        part_no = [part_no; sum(S(idx,startPt:endPt).*10.^((endPt-startPt):-1:0))];
                        part_address(idx,startPt:endPt) = numel(part_no); % set part address to each digit in space used in part 2
                    end
                    startPt = 0; endPt = 0; % clear number flags
                end
            end
        end
    end
end
