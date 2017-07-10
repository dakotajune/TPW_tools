function FinalInt = tinterp(Data)

FinalInt=nan(size(Data,1),size(Data,2),size(Data,3));
for i=1:size(Data,1) 
    for j=1:size(Data,2) %assumes third index is time
        C=squeeze(Data(i,j,:));
        if nansum(C)==0
            Int=nan(size(Data,3),1);
        else
            Int = naninterp(C);
        end
        FinalInt(i,j,:)=Int;
    end
 end
%  I=find(sum(Data,3)==nan);
%  FinalInt(I) = nan;
end