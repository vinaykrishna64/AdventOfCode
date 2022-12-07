clear all
clc
S = readlines('input.txt');
sys_size = 600; %a big mat size to include the file structure
f_name = repmat([" "],[sys_size, sys_size]); %file names
dirname =  repmat([" "],[sys_size, sys_size]); %dir names
f_size = zeros(sys_size); %file sizes
% hindsight filename array is uselles for the answers
%% size level name array construction 
lvl = 0;
j = 0;
for i = 1:numel(S)
    if S(i) == "$ cd .." %come back a lvl
        lvl = lvl - 1;
    elseif contains(S(i),"$ cd") %move up a lvl
        lvl = lvl + 1;
        cmd = S(i).split();
        cur_dir = cmd{3};
    elseif S(i) ~= "$ ls"    
        cmd = S(i).split();
        if cmd{1} ~= "dir" %add file entry and size entry /different arrays
            j = j + 1;
            dirname(j,lvl) = cur_dir;
            f_name(j,lvl) = cmd{2};
            f_size(j,lvl) = str2num(cmd{1});
        end
    elseif S(i) == "$ ls" %add an zero size entry to not miss just dir with no file
        j = j + 1;
        dirname(j,lvl) = cur_dir;
    end
end


%% travelling through levels and aggregating file size to get directory size
Dn{1,1} = "/";
Ds(1,1) = sum(f_size,"all");
fill_sv = [];
for i = 2:sys_size
    dirs = dirname(:,i);
    [dirs_fill,str_sv,N]= fill_mis_strs(dirs);
    unq_fiil = unique(dirs_fill);
    for j = 2:numel(unq_fiil)
        Dn{j,i} = str_sv(j);
        Ds(j,i) = sum(f_size(dirs_fill == unq_fiil(j),i:end),'all');
    end
    fill_sv = [fill_sv, dirs_fill];
end

% part 1 all folders less than 10k
part_1 = sum(Ds(Ds <= 100000),"all")
% part 2
free_space = 70000000 - Ds(1,1);
space_required = 30000000;
target = space_required - free_space;
Deletables = find((Ds - target) >= 0);
[part2_size,I_min] = min(Ds(Deletables))
part2_name = Dn{Deletables(I_min)}
%% function fill missing with previous 
% this might be possible with findgroups and fillmissing functions

function [dirs_fill,str_sv,N] = fill_mis_strs(dirs) %% crawl and make a number group array to group folders
    current_str = dirs(1);
    str_sv = current_str;   
    N = 1;
    dirs_fill = zeros(size(dirs));
    for i = 1:numel(dirs)
        if dirs(i) == current_str
           dirs_fill(i) = N;
        else
           current_str = dirs(i);
           N = N + 1;
           dirs_fill(i) = N;
           if current_str ~= " "
                str_sv = [str_sv; current_str];
           end
        end
    end
    dirs_fill(dirs == " ") = nan;
    dirs_fill = fillmissing(dirs_fill,'previous');
    dirs_fill(isnan(dirs_fill)) = 0;
end
