clear all
clc

data = char(readlines("day18.txt"));
sum{1} = data(1,:);
sz =size(data);
%% part 1
for i = 2:sz(1)
    sum{i} = snail_add(sum{i-1},data(i,:));
end
score = evail_snailSum(sum{end})
%% part2
scores = zeros(sz(1));
for i = 1:sz(1)
   for j = 1:sz(1)
       if i ~= j
          scores(i,j) = evail_snailSum(snail_add(data(i,:),data(j,:)));
       end
   end
end
M = max(scores,[],'all')

%% functions

function score = evail_snailSum(sum_1)
score = 0;
while true
    sr = find( sum_1 == ']');
    sl = find( sum_1 == '[');
    for i = 1:length(sr)
        I = find(sl < sr(i));
        J = max(sl(I));
        nums = split(sum_1(J+1:sr(i)-1) ,',');
        if ~strcmp(nums,sum_1(J+1:sr(i)-1)) 
            N1 = str2num(char(nums(1)));
            N2 = str2num(char(nums(2)));
            sum_1 = strjoin({ sum_1(1:J-1) ,num2str(3*N1+2*N2),sum_1(sr(i)+1:end)} ,'');
            break
        else
            continue
        end
    end
    if length(sr) == 0
        score = str2num(sum_1);
        break
    end
end

end


function sum_1 = snail_add(x,y)
sum_1 = make_pair(x,y);
while true
    sum_2 = sum_1;
    while true
        [sum_1,exploded] = explode_sum(sum_1);
        if ~exploded
            break
        end
    end
    
    [sum_1,splitted] = split_pairs(sum_1);
  
    if strcmp(sum_1,sum_2)
        break
    end
  
end
end

function [sum_1,exploded] = explode_sum(sum_1)
sr = find(sum_1 == ']');
sl = find(sum_1 == '[');
exploded = 0;
pos = 0;
% left most explode end '['
for i = 1:length(sr)
    I = find(sl < sr(i));
    if length(I) - i > 3
        pos = sr(i);
        break
    end  
end
if pos %if found
   exploded = 1; %note explosion
   I = find(sl < pos);
   J = sl(max(I));%find closing '['
    nums = split(sum_1(J+1:pos-1) ,','); %numbers in the exploding pair
    %find the left first number
    pos_n_L = 0;
   for i = J:-1:2
       if ~isnan(str2double(sum_1(i))) 
           pos_n_L = i;
           break
       end
   end
   pos_n_R = 0;
  %find the right first number
   L = length(char(sum_1));
   for i = pos:L-1
       if ~isnan(str2double(sum_1(i))) 
           pos_n_R = i;
           break
       end
   end
   if pos_n_L == 0 %no number to the left 
       %add the right numbers
       if ~isnan(str2double(sum_1(pos_n_R +1)))% check if the right first number is double digit
           numR =  str2num(char(nums(2))) + str2num(sum_1(pos_n_R:pos_n_R+1));
           %substitute the addition
           exp_sum = strjoin({ sum_1(1:pos_n_R-1) ,num2str(numR),sum_1(pos_n_R+2:end)} ,'');
       else
           numR =  str2num(char(nums(2))) + str2num(sum_1(pos_n_R));
           %substitute the addition
           exp_sum = strjoin({sum_1(1:pos_n_R-1) ,num2str(numR),sum_1(pos_n_R+1:end)} ,'');
       end
       exp_sum = strjoin({exp_sum(1:J-1) ,num2str(0),exp_sum(pos+1:end)} ,'');
   elseif pos_n_R == 0 %no number to the right
       %add the left numbers
       if ~isnan(str2double(sum_1(pos_n_L-1)))% check if the right first number is double digit
           numL =  str2num(char(nums(1))) + str2num(sum_1(pos_n_L-1:pos_n_L));
           %substitute the addition
           exp_sum = strjoin({ sum_1(1:pos_n_L-2),num2str(numL),sum_1(pos_n_L+1:end)} ,'');
           exp_sum = strjoin({exp_sum(1:J-1),num2str(0),exp_sum(pos+1:end)},'');
       else
           numL =  str2num(char(nums(1))) + str2num(sum_1(pos_n_L));
           %substitute the addition
           exp_sum = strjoin( {sum_1(1:pos_n_L-1),num2str(numL),sum_1(pos_n_L+1:end) },'');
           if numL >= 10
               exp_sum = strjoin({exp_sum(1:J),num2str(0),exp_sum(pos+2:end)},'');
           else
               exp_sum = strjoin({exp_sum(1:J-1),num2str(0),exp_sum(pos+1:end)},'');
           end
       end
       
   else
       %add the left numbers
       if ~isnan(str2double(sum_1(pos_n_L-1)))% check if the right first number is double digit
           numL =  str2num(char(nums(1))) + str2num(sum_1(pos_n_L-1:pos_n_L));
           %substitute the addition
           exp_sum = strjoin({ sum_1(1:pos_n_L-2),num2str(numL),sum_1(pos_n_L+1:end)} ,'');
       else
           numL =  str2num(char(nums(1))) + str2num(sum_1(pos_n_L));
           %substitute the addition
           exp_sum = strjoin( {sum_1(1:pos_n_L-1),num2str(numL),sum_1(pos_n_L+1:end) },'');
           if numL >= 10
               pos_n_R = pos_n_R +1;
               J = J  + 1;
               pos = pos + 1;
           end
       end
       
       %add the right numbers
       if ~isnan(str2double(exp_sum(pos_n_R +1)))% check if the right first number is double digit
           numR =  str2num(char(nums(2))) + str2num(exp_sum(pos_n_R:pos_n_R+1));
           %substitute the addition
           exp_sum = strjoin( {exp_sum(1:pos_n_R-1) ,num2str(numR),exp_sum(pos_n_R+2:end)},'');
       else
           numR =  str2num(char(nums(2))) + str2num(exp_sum(pos_n_R));
           %substitute the addition
           exp_sum = strjoin({exp_sum(1:pos_n_R-1) ,num2str(numR),exp_sum(pos_n_R+1:end)} ,'');
       end
       exp_sum = strjoin({exp_sum(1:J-1) ,num2str(0),exp_sum(pos+1:end)} ,'');
   end 
   
   sum_1 = exp_sum;
  
end

end

function [sum_1,splitted] = split_pairs(sum_1)
  L = length(char(sum_1));
  splitted = 0;
  for i = 1:L-1
      if ~isnan(str2double(sum_1(i))) & ~isnan(str2double(sum_1(i+1)))
          splitted = 1;
          split_pos = i;
          break
      end
  end

 if splitted
     num = str2num(sum_1(i:i+1));
     D1 = num2str(floor(num/2));
     D2 = num2str(ceil(num/2));
     new_pair = strjoin({'[',D1,',',D2,']'},'');
     sum_1 = strjoin({sum_1(1:i-1),new_pair,sum_1(i+2:end)},'');
 end
end

function pair = make_pair(x,y)
x = strtrim(x);
y = strtrim(y);
pair = strjoin({'[',x,',',y,']'},'');
end



