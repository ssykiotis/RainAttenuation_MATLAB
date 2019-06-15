function [ R_01_perMonth ] = r_split( control,R_01 )
%This function splits the rainrate values array in monthly arrays.
% INPUT: 8760 x 1 R_01: rainrate values
% 
% OUTPUT: {12x1} R_01_perMonth: struct with 1d-arrays containing
%                               the rainrate per month
%%
R_01_perMonth = {};
start = 1;
ending =0;
for i=1:12
    ending = ending+control.monthhours(i);
    R_01_perMonth{i}=R_01(start:ending,:);
    m = control.monthhours(i);
    n = size(R_01,2);
    start=ending+1;
end
end

