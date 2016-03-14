function [date_time,longitude,latitude] = clean_data(date_time,longitude,latitude)
%% conditions 
% longitude_range = [116.0, 116.8]; % min max 
% latitude_range = [39.5, 40.3]; % min max 

longitude_range = [114, 118]; % min max 
latitude_range = [38, 42]; % min max 

ind_lng = longitude > longitude_range(1) & longitude < longitude_range(2);
ind_lat = latitude > latitude_range(1) & latitude < latitude_range(2);
ind = ind_lng & ind_lat; 

%% cleaning
% display('data size before cleaning:');
% display(size(latitude,1));

longitude = longitude(ind);
latitude = latitude(ind);
date_time = date_time(ind);

% display('data size after cleaning:');
% display(size(latitude,1));









