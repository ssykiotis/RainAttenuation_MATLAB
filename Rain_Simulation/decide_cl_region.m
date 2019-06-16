function [ c_region ] = decide_cl_region(control)
% This function evaluateses the coordinates of the desired location and 
% determines the location's climatic region according to the Koeppen-Geiger
% Climatic Classification maps. Only the main climatic region is returned.
% 
% INPUT: 1 x 1 struct control: struct containing the control settings of the
%                               simulation
% OUTPUT: 1 x 1 char c_region: indicator that corresponds to one of the 5 main 
%                              climatic regions                             
%%
lon = control.locLon;
lat = control.locLat;

fname_regions = 'koppen_regions.csv';
fname_cords = 'koppen_cords.csv';

cords = csvread(fname_cords);

fileid_regions = fopen(fname_regions);
regions = textscan(fileid_regions,'%s');
fclose(fileid_regions);
regions = regions{1};

for i =1:length(regions)
    temp = regions{i};
    region(i) = temp(1);
end

[~,I] = min(abs(cords(:,1)-lon));
indices = find (cords(:,1)==cords(I,1));

id_r= cords(indices,:);
[~,I] = min(abs(id_r-lat));

c_region = regions(indices(I(2)));
c_region = char(c_region{1});
c_region = c_region(1);
end


