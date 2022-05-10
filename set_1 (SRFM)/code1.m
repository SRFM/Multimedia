%Serafeim-Ilias Antoniou AM: 2640

%Part_1: loading the cameraman image

lens = imread('cameraman.tif'); %command to open the given image
figure; %new window for shape design
imagesc(lens);  %printing the image on the screen
colormap(gray);

%Part_2: using the dct2 function for the DCT F(u,v)

DCT_lens = dct2(lens);

%Part_3: Setting the threshold |F(u,v)|<10 coefficients to zero

keep = DCT_lens;    %making a copy of the image
for r = 1: size(lens, 1)    %iteration through the rows
    for c = 1: size(lens, 2)    %iteration through the columns
        if (abs(DCT_lens(r, c)) < 10)   #abs -> |F(u,v)| < 10
            keep(r, c) = 0;
        end
    end
end
new_DCT_lens = uint8(idct2(keep));  %Reconstructed uint8 image with inversion
figure;
imagesc(new_DCT_lens);
title('Image with threshold |F(u,v)| < 10');
colormap(gray);
MSE = sum(sum((new_DCT_lens - lens).^2));
MSE = MSE / (size(lens, 1) * size(lens, 2));    %for rows & columns
PSNR = 10 * log10((255 * 255) / MSE);
display([PSNR]);    %showing the image
setToZero = sum(sum(keep == 0));    %searching for the ones who are set to zero
display([setToZero]);   %displaying all the elements that are zero

%Part_4: Same process for thresholds |F(u,v)|<15 and |F(u,v)|<20

keep = DCT_lens;    
for r = 1: size(lens, 1)    
    for c = 1: size(lens, 2)
        if (abs(DCT_lens(r, c)) < 15)
            keep(r, c) = 0;
        end
    end
end
new_DCT_lens = uint8(idct2(keep));
figure;
imagesc(new_DCT_lens);
title('Image with threshold |F(u,v)| < 15');
colormap(gray);
MSE = sum(sum((new_DCT_lens - lens).^2));
MSE = MSE / (size(lens, 1) * size(lens, 2));    
PSNR = 10 * log10((255 * 255) / MSE);
display([PSNR]);
setToZero = sum(sum(keep == 0));
display([setToZero]);

keep = DCT_lens;    
for r = 1: size(lens, 1)    
    for c = 1: size(lens, 2)
        if (abs(DCT_lens(r, c)) < 20)
            keep(r, c) = 0;
        end
    end
end
new_DCT_lens = uint8(idct2(keep));
figure;
imagesc(new_DCT_lens);
title('Image with threshold |F(u,v)| < 20');
colormap(gray);
MSE = sum(sum((new_DCT_lens - lens).^2));
MSE = MSE / (size(lens, 1) * size(lens, 2));    
PSNR = 10 * log10((255 * 255) / MSE);
display([PSNR]);
setToZero = sum(sum(keep == 0));
display([setToZero]);