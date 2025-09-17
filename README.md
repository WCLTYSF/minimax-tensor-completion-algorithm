Now we show how to run our code.

Please refer to the file "yunxing.m", where we execute the code. The operation of the program in this file is now explained.

"yunxing.m" is divided into three parts, each separated by %%%.

The first part contains the code for random tensor recovery. We set up random tensors of different sizes, including three-order tensor, four-order tensor, and five-order tensor. Taking the three-order tensor as an example:
a=tensor(rand(2,2,2));
b1=rand(2,50)-0.5;
b2=rand(2,50)-0.5;
b3=rand(2,50)-0.5;
C=ttm(a,{b1',b2',b3'});
c=double(C);
Original=c;
This generates a random third-order tensor. This part needs to be run within the tensor_toolbox. This way, we obtain a third-order tensor. We then need to sample this tensor to get the sampled tensor:
obs=im2double(Original);
X=sample(obs,0.3).
Next, run our main code:
[RSE,time,k]=ADMMEF(X,obs).

The second part is the code for color images. First, read the original image:
obs=imread('yuantu.png');
Then sample it and run the main code:
[X_hat,SSIM,PSNR,time,k]=ADMMEF(X,obs).
This same code is used for both color images and color videos. The only difference is that for color videos, the YUV format video first needs to be split into separate color images using the YUVduqu.m file.

The third part is the code for the random missing mask experiment. Similarly, first read the original image. It is important to note the selection of the random blocks for the mask:
P = imread('block_row.bmp');
P = im2double(P);
P = imresize(P, [size(obs,1), size(obs,2)]);
Omega = double(P > 0);
X = obs .* Omega; % imshow(X,[]);
This code overlays the mask blocks onto the original image to create the sampled tensor. Finally, run the main code:
[X_hat,SSIM,PSNR,time,k]=ADMMEF(X,obs).
