clear all
filename = 'input.txt';
S = readlines(filename);
S = S.replace(['-'],[' ']).erase(':').split(' ');
lms = str2double(S(:,1:2));
psswd = char(S(:,4));
cnts = sum(psswd == char(S(:,3)),2);
valids =  lms(:,1) <= cnts & cnts <= lms(:,2);

disp(sprintf('part_1 = %d',sum(valids)))

psswd(psswd == ' ') = '0';
I1 = sub2ind(size(psswd),[1:size(S,1)]',lms(:,1));
I2 = sub2ind(size(psswd),[1:size(S,1)]',lms(:,2));
valids2 = double(psswd(I1) == char(S(:,3))) + double(psswd(I2) == char(S(:,3)));
    
disp(sprintf('part_2 = %d',sum(valids2 == 1)))