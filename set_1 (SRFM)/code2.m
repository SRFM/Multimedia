% Serafeim-Ilias Antoniou AM: 2640

clear;
close all;

% blockproc related functions
function a = quantitizeQ(imblock, QQ)  
  a = round(imblock./QQ);
endfunction

function b = iQuantitizeQ(imblock, QQ)  
  b = imblock.*QQ;
endfunction

function c = getEntropy(imblock)
  c = entropy(imblock);
endfunction

q1 = [
  16 11 10 16 24 40 51 61;
  12 12 14 19 26 58 60 55;
  14 13 16 24 40 57 69 56;
  14 17 22 29 51 87 80 62;
  18 22 37 56 68 109 103 77;
  24 35 55 64 81 104 113 92;
  49 64 78 87 103 121 120 101;
  72 92 95 98 112 100 103 99;
];

q2 = 3 * q1;

% Part_1: Image reading
f = imread('cameraman.tif');

% Part_2: Image entropy
en = entropy (f)

% Part_3 & Part_4: DCT calculation for each block 8x8
B = blockproc (f, [8,8], @dct2);
%figure; imshow(B);

% Part_5: Quantitize using Q1 and Q2
Q1 = blockproc (B, [8,8], 'quantitizeQ', q1);
Q2 = blockproc (B, [8,8], 'quantitizeQ', q2);
%figure; imshow(Q1);
%figure; imshow(Q2);

% Part_6: Entropy calculation
en1 = entropy (Q1)
en1_QQ = blockproc (Q1, [8,8], 'getEntropy');
en2 = entropy (Q2)
en2_QQ = blockproc (Q2, [8,8], 'getEntropy');

% Part_7: Reverse quantitize
iQ1 = blockproc (Q1, [8,8], 'iQuantitizeQ', q1);
iQ2 = blockproc (Q2, [8,8], 'iQuantitizeQ', q2);
%figure; imshow(iQ1);
%figure; imshow(iQ2);
iQ1 = im2double(iQ1);
iQ2 = im2double(iQ2); 

% Part_8: Reverse DCT calculation for each block 8x8
iQ1idct = blockproc (iQ1, [8,8], @idct2);
iQ2idct = blockproc (iQ2, [8,8], @idct2);
%figure; imshow(iQ111);
%figure; imshow(iQ22);

% Part_9: uint8 image conversion
image1 = uint8 (iQ1idct);
image2 = uint8 (iQ2idct);

% Image printing and saving
figure('Name','Xrhsh Q1'); imshow(image1); imwrite(image1, 'cameramanQ1.jpg');
figure('Name','Xrhsh Q2'); imshow(image2); imwrite(image2, 'cameramanQ2.jpg');

% Part_10: PSNR calculation
PS1 = psnr(image1, f)
PS2 = psnr(image2, f)
