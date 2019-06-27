function [d1km, d2km]=lldistkm(latlon1,latlon2)
% format: [d1km d2km]=lldistkm(latlon1,latlon2)
% Distance:
% d1km: distance in km based on Haversine formula
% (Haversine: http://en.wikipedia.org/wiki/Haversine_formula)
% d2km: distance in km based on Pythagoras theorem
% (see: http://en.wikipedia.org/wiki/Pythagorean_theorem)
% After:
% http://www.movable-type.co.uk/scripts/latlong.html
%
% --Inputs:
%   latlon1: latlon of origin point [lat lon]
%   latlon2: latlon of destination point [lat lon]
%
% --Outputs:
%   d1km: distance calculated by Haversine formula
%   d2km: distance calculated based on Pythagoran theorem


radius=6371;
lat1=latlon1(1)*pi/180;
lat2=latlon2(1)*pi/180;
lon1=latlon1(2)*pi/180;
lon2=latlon2(2)*pi/180;
deltaLat=lat2-lat1;
deltaLon=lon2-lon1;
a=sin((deltaLat)/2)^2 + cos(lat1)*cos(lat2) * sin(deltaLon/2)^2;
c=2*atan2(sqrt(a),sqrt(1-a));
d1km=radius*c;    %Haversine distance

x=deltaLon*cos((lat1+lat2)/2);
y=deltaLat;
d2km=radius*sqrt(x*x + y*y); %Pythagoran distance

end
