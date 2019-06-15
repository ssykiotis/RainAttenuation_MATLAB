function R_01_perMonth = rain_values(control,c_region)

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
switch c_region
    case 'A'
        filename = '/rain_data/equatorial.csv';
    case 'B'
        filename = '/rain_data/arid.csv';
    case 'C'
        filename = '/rain_data/temperate.csv';
    case 'D'
        filename = '/rain_data/snow.csv';
    case 'E'
        filename = '/rain_data/snow.csv';
end


R_60 = csvread(filename); 
R_01 = r01_convert(R_60);

R_01_perMonth = r_split(control,R_01);


end

