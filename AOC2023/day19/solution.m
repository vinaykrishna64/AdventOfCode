clear all
filename            = 'input.txt';
S                   = readlines(filename);
I = find(S == "");
d = dictionary(S(1:I-1).extractBefore("{"),S(1:I-1).extractBetween("{","}"));
objects = S(I+1:end);
for idx = 1:numel(objects)
    x = str2double(objects(idx).extractBetween("x=",",m"));
    m = str2double(objects(idx).extractBetween("m=",",a"));
    a = str2double(objects(idx).extractBetween("a=",",s"));
    s = str2double(objects(idx).extractBetween("s=","}"));
    rating(idx) = x+m+a+s;
    AR(idx) = send_obj(x,m,a,s,d,"in");
end

fprintf('part 1 = %14d \n',sum(rating(AR==1)))


fprintf('part 2 = %14d \n',send_obj2(repmat([1,4000],4,1),d,"in",0)) 

%% functions


function out = send_obj(x,m,a,s,d,pipe)
    if strcmp(pipe,"A") 
        out = 1;
        return
    elseif strcmp(pipe,"R")
        out = 0;
        return
    end
    resolve = d(pipe);
    while contains(resolve,":")
        if eval(resolve.extractBefore(":"))
            resolve = resolve.extractBetween(":",",");
            resolve = resolve(1);
        else
            resolve = resolve.extractAfter(",");
        end
    end
    out = send_obj(x,m,a,s,d,resolve);
end

function out = send_obj2(lims,d,pipe,out)
% d is a dictionary of pipes -> rules
% pipe is a var which is a key or value... check main condition
% lims  start with [1,4000;1,4000;1,4000;1,4000] for xmas respectively and
% get reduced as they pass through pipes
    objs = ["x","m","a","s"];
    if strcmp(pipe,"A") 
        out = out + prod(diff(lims,1,2)+1);
        return
    elseif strcmp(pipe,"R")
        return
    end
    if contains(pipe,":") %% checks if it's a pipe or a rule
        ineq = pipe.extractBefore(":");
        resolve  = pipe;
        dummy = resolve.extractBetween(":",",");
        if contains(ineq,">")
            num = str2double(ineq.extractAfter(">"));
            obj = ineq.extractBefore(">");
            I = find(objs == obj);
            if all(lims(I,:) > num)
                out = send_obj2(lims,d,dummy(1));
            elseif  all(lims(I,:) < num)
                out = send_obj2(lims,d,resolve.extractAfter(","),out);
            else 
                lims2 = lims;
                lims2(I,:) = [num+1 lims(I,2)];
                out = send_obj2(lims2,d,dummy(1),out);
                lims2(I,:) = [lims(I,1) num];
                out = send_obj2(lims2,d,resolve.extractAfter(","),out);
            end
        else
            num = str2double(ineq.extractAfter("<"));
            obj = ineq.extractBefore("<");
            I = find(objs == obj);
            if all(lims(I,:) < num)
                out = send_obj2(lims,d,dummy(1));
            elseif  all(lims(I,:) > num)
                out = send_obj2(lims,d,resolve.extractAfter(","),out);
            else
                lims2 = lims;
                lims2(I,:) = [lims(I,1) num-1];
                out = send_obj2(lims2,d,dummy(1),out);
                lims2(I,:) = [num lims(I,2)];
                out = send_obj2(lims2,d,resolve.extractAfter(","),out);
            end
        end
    else
        out = send_obj2(lims,d,d(pipe),out);
    end
end


