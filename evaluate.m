img_dir =  'C:\Users\Oz\Documents\MATLAB\Fusion COVID-19\Multi-Exposed-Image-Fusion-using-Deep-Learning-master\Two\4F';
A = imread([img_dir '/A.jpeg' ]);
B = imread([img_dir '/A.jpeg' ]);
F = imread([img_dir '/F.svg' ]);
[PSNRAF,PSNRBF,SSIMAF,SSIMBF,SFA,SFB,SFF,STDA,STDB,STDF,MIAF,MIBF] = EVAL(A,B,F)