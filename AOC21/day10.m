clc
clear all
tic
fid = fopen('day10.txt');


%% main

n_lines = 98;
score = zeros(1,n_lines);
invalids = {[]};
score = zeros(1,n_lines);
count = 1;
for i = 1:n_lines%lines
    line_1 = fgetl(fid);
    closes = syntax_check(line_1);
    I = find(closes == 0);
    if length(I)
        S = map_scores(line_1(I));
        score(i,1:length(S)) = S;
        invalids(i) ={line_1(I(1))};
    else
        close_string = line_completer(line_1);
        score2(count) = map_scores_CLines(close_string);
        count = count + 1;
        score(i,1) = 0;
        invalids(i)={[]};
    end
end
%part 1
ans1 = sum(score(:,1))
%part 2
ans2 = median(score2);
sprintf('%d',ans2)

%% function
function total = map_scores_CLines(line)
illegal = [1 2 3 4];
illegals = ')]}>';
    for i = 1:length(line)
        I1 = find(illegals == line(i));
        score(i) = illegal(I1);   
    end
    total = 0;
    for i = 1:length(line)
        total = 5*total + score(i);
    end
end
function score = map_scores(line)
illegal = [3 57 1197 25137];
illegals = ')]}>';
for i = 1:length(line)
    I1 = find(illegals == line(i));
    score(i) = illegal(I1);   
end
end
function [closes] = syntax_check(line)
closes = zeros(1,length(line));
square_right = find(line == ']');
square_left = find(line == '[');
closes(square_left) = 1;
curly_right = find(line == '}');
curly_left = find(line == '{');
closes(curly_left) = 1;
round_right = find(line == ')');
round_left = find(line == '(');
closes(round_left) = 1;
angle_right = find(line == '>');
angle_left = find(line == '<');
closes(angle_left) = 1;

% square brackets
for i = 1:length(square_right)
    J = find(square_left < square_right(i));
    for j = 1:length(J)
       flag = is_closing(line(square_left(J(j)):square_right(i)));
       if flag == 1
           closes(square_right(i)) = 1;
           break
       end
    end
end

% curly brackets
for i = 1:length(curly_right)
    J = find(curly_left < curly_right(i));
    for j = 1:length(J)
       flag = is_closing(line(curly_left(J(j)):curly_right(i)));
       if flag == 1
           closes(curly_right(i)) = 1;
           break
       end
    end
end

% round brackets
for i = 1:length(round_right)
    J = find(round_left < round_right(i));
    for j = 1:length(J)
       flag = is_closing(line(round_left(J(j)):round_right(i)));
       if flag == 1
           closes(round_right(i)) = 1;
           break
       end
    end
end

% angle brackets
for i = 1:length(angle_right)
    J = find(angle_left < angle_right(i));
    for j = length(J):-1:1
       flag = is_closing(line(angle_left(J(j)):angle_right(i)));
       if flag == 1
           closes(angle_right(i)) = 1;
           break
       end
    end
end

end

function flag = is_closing(line)


sr = find(line == ']');
SR = length(sr);
sl = find(line == '[');
SL = length(sl);
cr = find(line == '}');
CR = length(cr);
cl = find(line == '{');
CL = length(cl);
rr = find(line == ')');
RR = length(rr);
rl = find(line == '(');
RL = length(rl);
ar = find(line == '>');
AR = length(ar);
al = find(line == '<');
AL = length(al);
    if (SR == SL) & (CR == CL) & (RR == RL) & (AR == AL) 
        if CR == sum(cr>cl) & SR == sum(sr>sl) & AR == sum(ar>al) & RR == sum(rr>rl) 
            flag = 1;
        else
            flag = 0;
        end
    else
        flag = 0;
    end
end


function close_string = line_completer(line)
close_string = '';
sr = find(line == ']');
SR = length(sr);
sl = find(line == '[');
SL = length(sl);
cr = find(line == '}');
CR = length(cr);
cl = find(line == '{');
CL = length(cl);
rr = find(line == ')');
RR = length(rr);
rl = find(line == '(');
RL = length(rl);
ar = find(line == '>');
AR = length(ar);
al = find(line == '<');
AL = length(al);

    for i = 1:length(line)
        f = 0;
        if strcmp(line(i),'[')
            J  = find(sr > i);
            if length(J)
                if sum(sl  >= i & sl  < sr(J(end))) > sum(sr > i)
                  for I = length(J)-1:-1:1
                      if sum(sl  >= i & sl  < sr(J(I))) == sum(sr > i & sr  <= sr(J(I)))
                          f = 1;
                      end
                  end
                  if f == 0
                     close_string = append(close_string,']');
                  end
                end 
            else
                close_string = append(close_string,']');
            end
        elseif strcmp(line(i),'{')
            J  = find(cr > i);
            if length(J)
                if sum(cl   >= i & cl   < cr(J(end))) > sum(cr > i)
                    for I = length(J)-1:-1:1
                        if sum(cl  >= i & cl  < cr(J(I))) == sum(cr > i & cr  <= cr(J(I)))
                            f = 1;
                        end
                     end
                  if f == 0
                     close_string = append(close_string,'}');
                  end
                end
            else
                close_string = append(close_string,'}');
            end 
        elseif strcmp(line(i),'(')
            J  = find(rr > i);
            if length(J)
                if sum(rl   >= i & rl   < rr(J(end))) > sum(rr > i)
                  for I = length(J)-1:-1:1
                        if sum(rl   >= i & rl  < rr(J(I))) == sum(rr > i & rr  <= rr(J(I)))
                            f = 1;
                        end
                  end
                  if f == 0
                     close_string = append(close_string,')');
                  end
                end
            else
                close_string = append(close_string,')');
            end        
        elseif strcmp(line(i),'<')     
            J  = find(ar > i); 
            if length(J)
                if sum(al >= i & al < ar(J(end))) > sum(ar > i)
                  for I = length(J)-1:-1:1
                        if sum(al   >= i & al  < ar(J(I))) == sum(ar > i & ar  <= ar(J(I)))
                            f = 1;
                        end
                  end
                  if f == 0
                     close_string = append(close_string,'>');
                  end
                end 
            else
                close_string = append(close_string,'>');
            end   
        end
    end
 close_string = flip(close_string);   
end
