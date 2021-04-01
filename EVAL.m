
function [PSNRAF,PSNRBF,SSIMAF,SSIMBF,SFA,SFB,SFF,STDA,STDB,STDF,MIAF,MIBF] = EVAL(A,B,F)


PSNRAF = psnr(F,A);
PSNRBF = psnr(F,B);

SSIMAF = ssim(F,A);
SSIMBF = ssim(F,B);

PCCAF = corrcoef(A,F);
PCCBF = corrcoef(B,F);

SFA = SpatialFrequency(A);
SFB = SpatialFrequency(B);
SFF = SpatialFrequency(F);

STDA = std2(A);
STDB = std2(B);
STDF = std2(F);

MIAF = 1.0; %MI(rgb2gray(F),rgb2gray(A));
MIBF = 1.0;
end