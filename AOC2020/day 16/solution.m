clear all
clc
filename = 'input.txt';
S = readlines(filename);
I = find(S == "");

s = S(1:I(1)-1).extractAfter(':');
s = strtrim(s.replace(["-"," or"],[" ", ""]));
lims = str2double(s.split());

yours = str2double(S(I(1)+2).split(","));

nearby = str2double(S(I(end)+2:end).split(","));
validtkt = zeros(numel(nearby));
counts = zeros(size(lims,1),1);
for idx = 1:numel(nearby)
    if ~any((nearby(idx) >= lims(:,1) & nearby(idx) <= lims(:,2))  | (nearby(idx) >= lims(:,3) & nearby(idx) <= lims(:,4)) )
        validtkt(idx) = 1;
    else
        counts((nearby(idx) >= lims(:,1) & nearby(idx) <= lims(:,2))  | (nearby(idx) >= lims(:,3) & nearby(idx) <= lims(:,4))) = counts((nearby(idx) >= lims(:,1) & nearby(idx) <= lims(:,2))  | (nearby(idx) >= lims(:,3) & nearby(idx) <= lims(:,4))) + 1 ;
    end
end
fprintf('part 1 = %14d \n',sum(nearby(validtkt == 1)))
[row,col] = ind2sub(size(nearby),find(validtkt == 1));
nearby(unique(row),:) = [];

%% make field map 
% rows each field, cols each cols
% map(row,col) is field that col can represent that field
nearby = [nearby;yours'];
field_map = zeros(size(lims,1),size(nearby,2));
C = ones(size(nearby,1),1);
for jdx = 1:size(nearby,2)
    for kdx = 1:size(lims,1) 
       field_map(kdx,jdx) = all((nearby(:,jdx) >= lims(kdx,1) & nearby(:,jdx) <= lims(kdx,2))  | (nearby(:,jdx) >= lims(kdx,3) & nearby(:,jdx) <= lims(kdx,4)));
    end
end

%% find the only combination
Col2Field = zeros(size(lims,1),1); % maps each field to respect column
[~,fi] = sort(sum(field_map,1));
field_map = field_map(:,fi);
% works from 1 to 20 possiblities of the map
for jdx = 1:size(lims,1)
    possibles = find(field_map(:,jdx) == 1);
    possibles = possibles(~ismember(possibles,Col2Field));
    Col2Field(fi(jdx)) = possibles;
end


ticket = dictionary(Col2Field,yours);

fprintf('part 2 = %14d \n',prod(ticket(1:6)))