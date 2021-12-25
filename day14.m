clc
clear all

data = readlines('day14.txt',"EmptyLineRule","skip");
polymer = char(data(1,:));
for i = 2:length(data)
    R = split(data(i,:),' -> ');
    combo(i-1) = R(1);
    add(i-1) = R(2);
end

%% main


%polymer_for pairs
P = strjoin({polymer(1:end-1),polymer(2:end)},'');
n = (length(char(P)))/2;
pairs = cellstr(reshape(P,n,[]));

n_combos = length(combo);
combo_count = zeros(1,n_combos);

% initial count
for i = 1:length(pairs)
    I = find(strcmp(pairs(i),combo));
    combo_count(I) = combo_count(I) + 1;
end

% Maps
rules = containers.Map(combo,add);
combo_index = containers.Map(combo,1:n_combos);
new_strs_1 = {};
new_strs_2 = {};
new_strs_3 = {};
for i = 1:n_combos
   C = char(combo(i));
   new_strs_1(i) = cellstr(strjoin({C(1),rules(combo(i))},''));
   new_strs_2(i) = cellstr(strjoin({rules(combo(i)),C(2)},''));
   C1 = char(combo(i));
   new_strs_3(i) = cellstr(C1(1));
end
growth_map_1 = containers.Map(combo,new_strs_1);
growth_map_2 = containers.Map(combo,new_strs_2);
first_letter = containers.Map(combo,new_strs_3);
last_pair = char(pairs(end));
%% turns
steps = 40;
for step = 1:steps
    I = find(combo_count > 0);
    combo_count_new = zeros(1,n_combos);
    for i = 1:length(I)
        generated = growth_map_1(combo(I(i)));
        gen_index = combo_index(generated);
        combo_count_new(gen_index) = combo_count_new(gen_index)+ combo_count(I(i));
        generated = growth_map_2(combo(I(i)));
        gen_index = combo_index(generated);
        combo_count_new(gen_index) = combo_count_new(gen_index)+combo_count(I(i)); 
    end
    combo_count = combo_count_new;
end  

s =  unique(add);
letter_counts = zeros(1,length(s));
letter_map = containers.Map(s,1:length(s));

I = letter_map(last_pair(2));
letter_counts(I) = 1; %add last letter
I = find(combo_count > 0);
for i = 1:length(I)
    I1 = letter_map(first_letter(combo(I(i))))
    letter_counts(I1) = letter_counts(I1) + combo_count(combo_index(combo(I(i))));
end

letter_counts = sort(letter_counts);

ans = letter_counts(end) - letter_counts(1);
sprintf('%d',ans)