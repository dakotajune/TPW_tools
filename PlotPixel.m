function plot=PlotPixel(matrix,lat,lon,year)
%currently works for a full dataset i.e. 360x180

n=year-1988;
timeind1=1+(365*n);
timeind2=timeind1+364;
latt=90+lat;
lonn=180+lon;
func=matrix(lonn,latt,timeind1:timeind2);
func(isnan(func))=0;
plot=squeeze(func);
PlotSmooth(plot);