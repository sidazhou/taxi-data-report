function [date_time,longitude,latitude] = importfile(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   [DATE_TIME,LONGITUDE,LATITUDE] = IMPORTFILE(FILENAME) Reads data from
%   text file FILENAME for the default selection.
%
%   [DATE_TIME,LONGITUDE,LATITUDE] = IMPORTFILE(FILENAME, STARTROW, ENDROW)
%   Reads data from rows STARTROW through ENDROW of text file FILENAME.
%
% Example:
%   [date_time,longitude,latitude] = importfile('366.txt',1, 99494);
%
%    See also TEXTSCAN.
 
%% Initialize variables.
delimiter = ',';
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%% Format string for each line of text:
%   column2: datetimes (%{yyyy-MM-dd HH:mm:ss}D)
%	column3: double (%f)
%   column4: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*q%{yyyy-MM-dd HH:mm:ss}D%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
date_time = posixtime(dataArray{:, 1});
longitude = dataArray{:, 2};
latitude = dataArray{:, 3};

% For code requiring serial dates (datenum) instead of datetime, uncomment
% the following line(s) below to return the imported dates as datenum(s).

% date_time=datenum(date_time);

end
