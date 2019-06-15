function [ R_01 ] = r01_convert( data) 
%This function converts hourly rainrate data to a finer scale. For now,
%only 60min-1min conversion is supported according to paper by Luini et. al.

% INPUT:  8760x11 data: hourly Rainrate values
%         
% 
% OUTPUT: 8760x11 R_01: minute-wise Rainrate values  
%         
%        
%%             
    a = 0.509;
    b = 1.394;
    R_01 = a.*data.^b; 

end