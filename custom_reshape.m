function [ y ] = custom_reshape( x )
%This function takes a matrix as input and reshapes to a vector. 

% INPUT:  m x n     x: any matrix of dimensions m,n
%
% OUTPUT:  m*n x 1  y: reshaped vector
%                  
%%
m = size(x,1);
n = size(x,2);

y = zeros(m*n,1);
start =1;
ending = start+n-1;

for i=1:m
    y(start:ending,1)=x(i,:); 
    start = start+n;
    ending = ending+n;
end


end

