function sq = closest_points(latMap,lonMap,idxLat,idxLon,Lat,Lon)
%This function returns the square with the 4 closest points to the chosen
%location

% INPUT:  1x1    Lat:    Latitude of the chosen location
%         1x1    Lon:    Longitude of the chosen location
%         1x1    idxLat: Index of chosen location's Latitude
%         1x1    idxLon: Index of chosen location's Longitude
%         722x1  latMap: Map with all Latitudes
%         1442x1 lonMap: Map with all Longitudes
% 
%
% OUTPUT:  4x2 sq: Grid with indices of the4 
%                  closest points to the chosen location     
%%
sq1 = [idxLat  , idxLon-1;
       idxLat-1, idxLon-1;
       idxLat-1, idxLon;
       idxLat  , idxLon ];

sq2 = [idxLat  , idxLon;
       idxLat-1, idxLon;
       idxLat-1, idxLon+1;
       idxLat  , idxLon+1];

sq3 = [idxLat+1, idxLon-1;
       idxLat  , idxLon-1;
       idxLat  , idxLon;
       idxLat+1, idxLon];

sq4 = [idxLat+1, idxLon;
       idxLat  , idxLon;
       idxLat  , idxLon+1;
       idxLat+1, idxLon+1];

sqs = {sq1,sq2,sq3,sq4};

for i=1:4
    sq = sqs{i};
    d = 0;
    for j=1:4
        d = d + (latMap(sq(j,1))-Lat)^2 + (lonMap(sq(j,2))-Lon)^2;
    end
    dist(i) = d;
end

[~,minInd] = min(dist);

sq = sqs{minInd};

end