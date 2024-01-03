clear all
clc
%% extract the target file and make one lon string
filename            = 'solution.m';
S                   = readlines(filename);
S = reshape(S,1,numel(S)); 

%% replace some annoying things with spaces in the string
S = S.join(' ').replace(["=",";",".",")"],[" "," "," "," "]); 
%% use regex to get every word  and use unique to get the unqiue ones
matchStr  = regexp(S,'\w+','match');
matchStr = unique(matchStr);
%% use the exist function which returns 5 for buil-tin functions
types = arrayfun(@(x)exist(x),matchStr);
matchStr(types == 5)

%% need to remove comments somehow