clear all
clc

S = readlines("input.txt").replace(["Valve "," has flow rate=","; tunnels lead to valves ","; tunnel leads to valve ",", "],["",",",",",",",","]);
keys = [];
conns = {};
for i = 1:numel(S)
    S2 = S(i).split(",");
    keys = [keys; S2(1)];
    vals(i) = str2double(S2(2));
    conns{i} =  [S2(3:end)];
end
M = containers.Map(keys,1:numel(keys));
Conn = cellfun(@(x)arrayfun(@(y)M(y),x),conns,'UniformOutput',false);
I = find(keys == "AA");

%% part 1
paths = {[I]};
for j = 1:30 %mins
    paths =  newpaths(paths,vals,30,Conn);
    if  mod(j,5) == 0 %lose 3/4th data at every 5 steps/mins
         P = 0;
         for i = 1:numel(paths)
             P(i) = pressure_sum(paths{i},vals);
         end
         [m,J] = maxk(P,floor(numel(paths)/4));
         paths = paths(J);
    end
    % length check for break
    if all(cellfun(@numel,paths) > 29)
        break
    end
end

P = 0;
c = 1;
 for i = 1:numel(paths)
     if numel(paths{i}) == 30
        P(c) = pressure_sum(paths{i},vals);
        c = c + 1;
     end
 end
[part_1 ,J1] = max(P);
paths{J1}
part_1
%% part 2
paths = {[I;I]};
openables = find(vals > 0);
for j = 1:25 %mins
    paths =  newpaths2(paths,vals,Conn,openables); 
    if  j > 4 % lose 7/8th data at every 1 steps/mins over 4mins
         %there are a lot of paths forming you open at least 1 valve at
         %this point so this removes all zeros at least
         P = 0;
         for i = 1:numel(paths)
             P(i) = pressure_sum2(paths{i},vals,j+1);
         end
         [m,J] = maxk(P,floor(numel(paths)/8));
         paths = paths(J);
    end
end

for i = 1:numel(paths)
   P2(i) = pressure_sum2(paths{i},vals,26);
end
[part_2 ,J2] = max(P2);
paths{J2}
part_2
%% functions

function [new_paths] = newpaths(paths,vals,max_L,Conn) 
   %extends two mins in one minute depending on situation
    new_paths = {};
    for i = 1:numel(paths) %extend path into the next minute
        new = Conn{paths{i}(end)}; %available choices based on last valve
        if numel(paths{i}) > 1
            new = new(new ~= paths{i}(end-1));
        end
        if numel(paths{i}) < max_L %stop when 30 mins reached
            for k = 1:numel(new) %for each choice
                new_paths{end+1} = [paths{i} new(k)]; %move to valve
                % don't open already opened valves or zero flow valves
                if ~any(paths{i}(1:end-1) == new(k) & paths{i}(2:end) == new(k)) && vals(new(k))
                    new_paths{end+1} = [paths{i} new(k) new(k)]; %move and open valve
                end
            end
        else
            new_paths{end+1} = paths{i}; %stop loss of old perfect length routes
        end
    end
end
function [new_paths] = newpaths2(paths,vals,Conn,openables)
    new_paths = {};
    for i = 1:numel(paths) %extend path into the next minute
        if ~check_openables(paths{i},openables)
            if size(paths{i},2) > 2
                if  paths{i}(1,end-1) ~= paths{i}(1,end) && paths{i}(2,end-1) ~= paths{i}(2,end)
                    new1 = [paths{i}(1,end); Conn{paths{i}(1,end)}]; %available choices based on last valve
                    new2 = [paths{i}(2,end); Conn{paths{i}(2,end)}]; %available choices based on last valve
                elseif paths{i}(1,end-1) == paths{i}(1,end)
                    new1 = Conn{paths{i}(1,end)}; %available choices based on last valve
                    new2 = [paths{i}(2,end); Conn{paths{i}(2,end)}]; %available choices based on last valve
                elseif paths{i}(2,end-1) == paths{i}(2,end)
                    new1 = [paths{i}(1,end); Conn{paths{i}(1,end)}]; %available choices based on last valve
                    new2 = Conn{paths{i}(2,end)}; %available choices based on last valve
                end
            else
                new1 = [paths{i}(1,end); Conn{paths{i}(1,end)}]; %available choices based on last valve
                new2 = [paths{i}(2,end); Conn{paths{i}(2,end)}]; %available choices based on last valve
            end
            for k1 = 1:numel(new1) %for each choice
                for k2 = 1:numel(new2) %for each choice
                    [out_flg,path_out] = create_path(paths{i},new1(k1),new2(k2),vals);
                    if out_flg
                        new_paths{end+1} = path_out;
                    end
                end
            end
        else
            new_paths{end+1} = paths{i}; %if all valves opened
        end
    end
end
function [flg] = check_open(path,k)
    flg = 0;
    if  ~any(path(1,1:end-1) == k & path(1,2:end) == k) && ~any(path(2,1:end-1) == k & path(2,2:end) == k)
        flg = 1; %return 1 for not open
    end
end
function [flg] = check_openables(path,openables)
    s = 0;
    for i = 1:numel(openables)
        s = check_open(path,openables(i));
    end
    flg = s == numel(openables);
end
function [out_flg,path] = create_path(path,k1,k2,vals)
    out_flg = 0;
    if k1 ~= path(1,end) && k2 ~= path(2,end)
        out_flg = 1;
    elseif k1 == path(1,end) && k2 ~= path(2,end)
        if check_open(path,k1) && vals(k1)
            out_flg = 1;
        end
    elseif k1 ~= path(1,end) && k2 == path(2,end)
        if check_open(path,k2) && vals(k2)
            out_flg = 1;
        end
    elseif k1 == path(1,end) && k2 == path(2,end)
        if k1 ~= k2
            if check_open(path,k1) && check_open(path,k2) && vals(k1) && vals(k2)
                out_flg = 1;
            end
        end
    end
    if out_flg
        path(:,end+1) = [k1 ;k2];
    end
end
function [p,P] = pressure_sum(path,vals)
    P = zeros(1,numel(path));
    for i = 3:numel(path)
        if path(i) == path(i-1)
            P(i) = P(i-1) + vals(path(i));
        else
            P(i) = P(i-1);
        end
    end  
    p = sum(P);
end

function [p,P] = pressure_sum2(path,vals,L)
    P = zeros(1,size(path,2));
    for i = 2:size(path,2)
        P(i) = P(i-1);
        if path(1,i) == path(1,i-1)  
            P(i) = P(i) + vals(path(1,i));
        end
        if path(2,i) == path(2,i-1)
            P(i) = P(i) + vals(path(2,i)); 
        end
    end  
    if size(path,2) < L
        n = L - size(path,2);
        P(end:end+n) = P(end);
    end
    p = sum(P);
end