close all
%clear
clc
addpath('metrics')
addpath(genpath(cd))
%%
%load vgg19.mat;
path=uigetdir('*');
I=load_images(path);
n=size(I,4);
subplotrows=ceil(n/3);
figure('Name','Input sequence');
for ii=1:n
    subplot(subplotrows,3,ii); imshow(I(:,:,:,ii));
end
%%
W_CNN=double(cnnFeatures_newnew(I,vgg19));
RGB_proposed=zeros([size(I,1),size(I,2),size(I,3)]);
for ii=1:n
    for jj=1:3
        temp(:,:,jj)=W_CNN(:,:,jj,ii).*I(:,:,jj,ii);
    end
    RGB_proposed=RGB_proposed+temp;
end

R_hybrid=postprocessing(double(RGB_proposed));

figure('Name','Result by CNN features and fusion');
imshow((R_hybrid)) ;
%%
for ii=1:size(I,4)
    subplot(subplotrows,3,ii); imhist(I(:,:,:,ii));
end
figure
imhist(R_hybrid)
figure
imshow(R_hybrid)

%% Evaluation
A = I(:,:,:,1);
B = I(:,:,:,2);
F = R_hybrid;

x = {rgb2gray(A),rgb2gray(B)};
%fusion_perform_fn(F,x)

Qg1=metricXydeas(A,B,F);
Qy1=QY(A,B,F);
Qcb1=metricChenBlum(A,B,F);
gA = rgb2gray(A);
gB = rgb2gray(B);
gF = rgb2gray(F);
Qabfl = Qabf(gA, gB, gF);
Qmi1=QualityMetrics(round(gA * 255),round(gB * 255),round(gF * 255));

[Qg1 Qy1 Qcb1 Qabfl Qmi1]

[PSNRAF,PSNRBF,SSIMAF,SSIMBF,SFA,SFB,SFF,STDA,STDB,STDF,MIAF,MIBF] = EVAL(A,B,F);

[PSNRAF,PSNRBF,SSIMAF,SSIMBF,SFA,SFB,SFF,STDA,STDB,STDF,MIAF,MIBF]
