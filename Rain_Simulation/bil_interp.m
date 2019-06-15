function I_rc = bil_interp(data,points,Lat,Lon,latMap,lonMap)
%This function performs bilinear interpolation according to ITU-R P.1144

% INPUT:  1x4    data: data of grid points (eg. Monthly total Rainfall values)  
%         4x2    points: Indices of gridpoints 
%         1x1    Lat: Chosen location's Latitude
%         1x1    Lon: Chosen location's Longitude
%         722x1  latMap: Map with all Latitudes
%         1442x1 lonMap: Map with all Longitudes
% 
%
% OUTPUT:  1x1 I_rc: Interpolated value
%%        
R = points(1,1);
C = points(1,2);
r = R+(Lat-latMap(R))/(latMap(R+1)-latMap(R));
c = C+(Lon-lonMap(C))/(lonMap(C+1)-lonMap(C));

I_rc = data(1)*(R-r+1)*(C-c+1) + data(2)*(r-R)*(C-c+1) + data(3)*(R-r+1)*(c-C) + data(4)*(r-R)*(c-C);
end