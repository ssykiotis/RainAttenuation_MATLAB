function [ c_region ] = decide_cl_region(control)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

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


