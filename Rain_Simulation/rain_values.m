function R_01_perMonth = rain_values(control,c_region)
% This function takes as input the desired location's climatic region 
% indicator and reads the corresponding rain intensity data from external 
% files. Then, the rain intensity values are converted to a 1-minute time 
% scale. Finally, they are split and assigned to their corresponding month. 
% 
% INPUT: 1 x 1 struct control : struct containing simulation parameters.
%        1 x 1 char  c_region : climatic region indication
%        
% OUTPUT: 1 x 12 cell array   : each cell contains rain data for the
%                               corresponding month of the year
%%
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

