function W_CNN=cnnFeatures_newnew(I,net)
beta=0.2;  % constant used in exposure mask calculation
for ii=1:size(I,4)
    %fetaure extraction from first layer
    features(:,:,:,ii) = activations(net,I(:,:,:,ii),1,'OutputAs','channels');
    features(:,:,:,ii)=double(features(:,:,:,ii));
    %     features(:,:,ii)=(newfeatures(:,:,1,ii)+newfeatures(:,:,2,ii)+newfeatures(:,:,3,ii))/3;
    for jj=1:size(I,3)
        temp=norm(features(:,:,jj,ii),1);
        V(:,:,jj,ii)=(features(:,:,jj,ii)./temp);   %strength of feature vector
%         temp1=norm(features(:,:,jj,ii));
%         sij(:,:,jj,ii)=(features(:,:,jj,ii)./temp1); %temporal consistency
%         S_temp(:,:,jj,ii)=exp(-((sij(:,:,jj,ii)).^2)./(2*0.05^2));
        % exposure mask calculation
        %         grayI(:,:,:,ii)=normalize(rgb2gray(I(:,:,:,ii)));
%         for pp=1:size(I,1)
%             for qq=1:size(I,2)
%                 if (beta<I(pp,qq,jj,ii))&&(I(pp,qq,jj,ii)<(1-beta))
%                     M(pp,qq,jj,ii)=1;
%                 else
%                     M(pp,qq,jj,ii)=0;
%                 end
%             end
%         end       
    end
end
for ii=1:size(I,4)
    for jj=1:size(I,3)
        temp1=norm(features(:,:,jj,ii));
        temp2(:,:,jj,ii)=(features(:,:,jj,ii)./temp1); %temporal consistency
    end
end
S_temp=euclideanDist(temp2); %temporal consistency
S=zeros(size(I,1),size(I,2),size(I,3));
V_imagesum=zeros(size(I,1),size(I,2),size(I,3));
denom=zeros(size(I,1),size(I,2),size(I,3));
for ii=1:size(I,4)
    S=S+S_temp(:,:,:,ii); % temporal consistemcy
    V_imagesum=V_imagesum+V(:,:,:,ii);
%     denom=denom+V(:,:,:,ii).*S_temp(:,:,:,ii).*M(:,:,:,ii);
    denom=denom+V(:,:,:,ii);

end
% weights calculation
for ii=1:size(I,4)
%     W_CNN(:,:,:,ii)=(V(:,:,:,ii).*S.*M(:,:,:,ii))./(denom+10e-5);
      W_CNN(:,:,:,ii)=(V(:,:,:,ii)./(denom));

%     for jj=1:3
%         W_CNN(:,:,jj,ii)=medfilt2(W_CNN(:,:,jj,ii));    
%     end
end
