%%%%%%%%%%%%% random tensor recovery %%%%%%%%%%%%
%three-order tensor
a=tensor(rand(2,2,2)); % The 2 means the rank of this tensor.
b1=rand(2,50)-0.5;
b2=rand(2,50)-0.5;
b3=rand(2,50)-0.5;
C=ttm(a,{b1',b2',b3'});
c=double(C);
Original=c; % Randomly generate a tensor (tensor_toolbox).
%four-order tensor
a=tensor(rand(2,3,3,5));
b1=rand(2,20)-0.5;
b2=rand(3,20)-0.5;
b3=rand(3,20)-0.5;
b4=rand(5,20)-0.5;
C=ttm(a,{b1',b2',b3',b4'});
c=double(C);
Original=c; %Randomly generate a tensor (tensor_toolbox).
%five-order tensor
a=tensor(rand(2,2,2,2,2));
b1=rand(2,20)-0.5;
b2=rand(2,20)-0.5;
b3=rand(2,20)-0.5;
b4=rand(2,20)-0.5;
b5=rand(2,20)-0.5;
C=ttm(a,{b1',b2',b3',b4',b5'});
c=double(C);
Original=c;  %Randomly generate a tensor (tensor_toolbox).

obs=im2double(Original);
X=sample(obs,0.3);
[RSE,time,k]=ADMMEF(X,obs);
imshow(obs,[])     % original image 
imshow(X,[])        % observed image
imshow(X_hat,[])  % recovery image

%%%%%%%%%%%%% color image %%%%%%%%%%%%%%%%%%
obs=imread('yuantu.png');
obs=im2double(obs);
X=sample(obs,0.3);
[X_hat,SSIM,PSNR,time,k]=ADMMEF(X,obs);
imshow(obs,[])     % original image 
imshow(X,[])        % observed image
imshow(X_hat,[])  % recovery image

%%%%%%%%%%%%% random missing mask %%%%%%%%%%%%%
obs=imread('yuantu.jpg');
obs=im2double(obs);
%structural missing mask
P = imread('block_row.bmp');
P = im2double(P);
P = imresize(P, [size(obs,1), size(obs,2)]);  
Omega = double(P > 0);  
X = obs .* Omega; % imshow(X,[]);
[X_hat,SSIM,PSNR,time,k]=ADMMEF(X,obs);
