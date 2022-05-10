% Antoniou Serafeim-Ilias | AM: 2640
%The implementation of this project is done with some additional files! 
%Please include ALL of them for the proper results!

%Part #1 - Opening the frames

fin = fopen ('frame0.raw','r');
frame0 = fread(fin,[176,144])';
fin = fopen ('frame1.raw','r');
frame1 = fread(fin,[176,144])';
fclose(fin);

%Getting the frame dimensions
col = size(frame0,1);
row = size(frame0,2);

%Part #2 

QP = 42;

%Splitting frame0 into 4x4
[frameDCT,frameQUANT] = Conversion(col,row,frame0,QP);

%Entropy calculation
absEntropy1 = entropy(uint8(abs(frameQUANT)));
display(absEntropy1);
[frameInvQUANT,frameInvDCT] = InvConversion(col,row,frameQUANT,QP);
postScale0 = round(frameInvDCT/64);

%PSNR calculation
PSNR = psnr(frame0,postScale0);
display(PSNR);

%Part #3

motVect = zeros(144,176);
[motVect] = motionVector(8,col,row,postScale0,frame1);

%Part #4
errorQUANT = zeros(144,176);
error = frame1 - motVect;

%Error splitting 
[errorDCT,errorQUANT] = Conversion(col,row,error,QP);

%errorQUANT Entropy Calculation
absEntropy2 = entropy(uint8(abs(errorQUANT)));
display(absEntropy2);
errorInvDCT = zeros(144,176);
[errorInvQUANT,errorInvDCT] = InvConversion(col,row,errorQUANT,QP);
errorKap = round(errorInvDCT/64);
postScale1 = motVect + errorKap;

%PSNR calculation
PSNR = psnr(frame1,postScale1);
display(PSNR);

colormap(gray);
%imagesc(postScale0);
imagesc(postScale1);