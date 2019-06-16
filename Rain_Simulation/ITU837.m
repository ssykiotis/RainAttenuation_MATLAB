function [ t,MT,P_0,r] = ITU837( control )
%This function calculates useful climatic statistics for a given map 
%location.
%
% INPUT:  1x1 :control.locLat, Latitude of the desired location
%         1x1 :control.locLon  Longitude of the desired location
% 
% OUTPUT: 12x1 t:  monthly mean temperaturein C
%         12x1 MT: monthly total rainfall
%         12x1 r: side information, used for prediction of rain data
%         12x1 P_0: monthly probability of rain in percent
%%
Lat = control.locLat;
Lon = control.locLon;

%Calculate monthly mean surface Temperatures (K)
latMap = textread('lat_T.txt');
latMap = latMap(:,1);
lonMap = textread('lon_T.txt');
lonMap = lonMap(1,:)';

[ ~, idxLat ] = min(abs(latMap-Lat));
[ ~, idxLon ] = min(abs(lonMap-Lon));

for i=1:12
   T_i = textread(sprintf('T_Month%.2d.txt',i));
   T(i) = T_i(idxLat,idxLon);
end
%%
%Calculate mean total Rainfall (MT) in mm
latMap = textread('lat_MT.txt');
latMap = latMap(:,1);
lonMap = textread('lon_MT.txt');
lonMap = lonMap(1,:)';

[ ~, idxLat ] = min(abs(latMap-Lat));
[ ~, idxLon ] = min(abs(lonMap-Lon));

sq = closest_points(latMap,lonMap,idxLat,idxLon,Lat,Lon);

for i=1:12
   MT_i = textread(sprintf('MT_Month%.2d.txt',i));
   for j=1:4
      MT_inter(i,j) = MT_i(sq(j,1),sq(j,2));
   end
   MT(i) = bil_interp(MT_inter(i,:),sq,Lat,Lon,latMap,lonMap);
end



%%
%calculate r_ii and probability of rain
t = T-273.15;       %Convert K to C
for i=1:12
    if t(i)>=0
       r(i) = 0.5874^(0.083*t(i)); 
    else
       r(i) = 0.5874;
    end
    P_0(i) = 100*MT(i)/(24*control.monthdays(i)*r(i));
    if (P_0(i)>70)
        P_0(i) = 70;
        r(i) = 100*MT(i)/(70*24);
    end
end

