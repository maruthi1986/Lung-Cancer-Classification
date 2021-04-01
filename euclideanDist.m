function S=euclideanDist(temp2)
for ii=1:size(temp2,4)
    sjj=zeros([size(temp2,1),size(temp2,2),size(temp2,3)]);
    for jj=1:size(temp2,4)
        for kk=1:size(temp2,3)
            diff(:,:,kk)=(temp2(:,:,kk,ii)-temp2(:,:,kk,jj));
            expdiff(:,:,kk)=exp(-diff(:,:,kk)/(2*(0.05)^2));
        end
        sjj=sjj+expdiff;
    end
    S(:,:,:,ii)=sjj;
    for kk=1:size(temp2,3)
        S(:,:,kk,ii)=S(:,:,kk,ii)./norm(S(:,:,kk,ii),1);
    end
end
