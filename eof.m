function [EOFmodes, MAP, H, PCTS] = eof(Data)
%for 3-D data array (lon, lat, time)
TimeFirst=permute(Data, [3 1 2]);
TwoD=map2mat(ones(size(TimeFirst,2),size(TimeFirst,3)),TimeFirst);
%t=1:length(TwoD(:,1)); 
%X=TwoD-ones(size(t'))*mean(TwoD); 
I=find(nansum(TwoD,1)>0);
R=nancov(TwoD(:,I));
[V,Lambda]=eigsort(R);
AR=V*Lambda.^0.5;
PoV=100*diag(Lambda)/trace(Lambda);
EOFmodes=PoV;
%i=1;
%Map(1:size(TwoD,2),1)=nan;
%Map(I,1)=AR(:,1);
%MAP=reshape(Map,[size(Data,1) size(Data,2)])';
%PCTS=TwoD(:,I)*V(:,i)/sqrt(Lambda(i,i));

Map(1:size(TwoD,2),1)=nan;
MAP(1:size(Data,2),1:size(Data,1),1:size(PoV))=nan;
for j=1:size(PoV)
Map(I,1)=AR(:,j);
MAP(:,:,j)=reshape(Map,[size(Data,1) size(Data,2)])';
H(:,j)=TwoD(:,I)*V(:,j)/sqrt(Lambda(j,j));
  pointsperyear=26;
  coeffweekly=ones(1,pointsperyear)/pointsperyear;
PCTS=filter(coeffweekly,1,H);
end
end

