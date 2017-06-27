function Plot = PixelTS(matrix, lat,lon)

figure
for k=1988:2009
n=k-1987;
subplot(6,4,n);
PlotPixelGOM(matrix,lat,lon,k);
end
end