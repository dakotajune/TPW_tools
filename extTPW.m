function precipitable_water = extTPW(lat1,lat2,lon1,lon2)
% precipitable_water = extTPW(lat1,lat2,lon1,lon2)
%
% Must be modified for file path, and currently time bounds must be inputted once running the function. 

myFolder='/Users/Coco/PrecipitableWater/RawDataMonthly';
if ~isdir(myFolder)
    errorMessage=sprintf('Error: The following folder does not exist:\n%s', myFolder);
    uiwait(warndlg(errorMessage));
    return;
end
filePattern = fullfile(myFolder, '*.nc3.nc');
theFiles = dir(filePattern);
total_time_measurements=length(theFiles)
prompt1 = 'choose a lower time bound: ';
timeind1 = input(prompt1);
prompt2 = 'choose an upper bound: ';
timeind2 = input(prompt2);
precipitable_water=nan(lon2-lon1,lat2-lat1,timeind2-timeind1);
k = timeind1:timeind2
for j=1:length(timeind1:timeind2)
    baseFileName = theFiles(k(j)).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1,'Now reading %s\n', fullFileName);
    lat = ncread('tpw_v07r01_198801.nc3.nc','latitude');
    if lat1>-89.5
        I=find(lat1-lat<0);
        latind1 = I(1);
    else
        latind1=0
    end
    if lat2<89.5
        I=find(lat2-lat<0);
        latind2 = I(1)-1;
    else
        latind2=180;
    end
    lon = ncread('tpw_v07r01_198801.nc3.nc','longitude');
    I=find(lon1-lon<0);
    lonind1 = I(1);
    if lon2<360
    I=find(lon2-lon<0);
    lonind2 = I(1)-1;
    end
    if lon2==360
       lonind2=360;
    end
    prec_wat = ncread(baseFileName,'precipitable_water');
    precipitable_water(:,:,j)=prec_wat(lonind1:lonind2,latind1:latind2);
    clear prec_wat;
end
