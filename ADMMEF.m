function [X_hat,SSIM,PSNR,time,k]=ADMMEF(Sample,Original)
% [X,PSNR,RSE,time,k]=ADMMEF(Sample,Original)
% [RSE,time,k]=ADMMEF(Sample,Original)
Omega=logical(Sample);
maxiter=1000;
epsilon1=10^(-7);
epsilon=10^(-7);
% epsilon1=10^(-1);
% epsilon=10^(-1);

miu=1/1.1;
% miu=1/1.045;
lambda=100;
X=Sample;
Z1=X;
Z2=X;
Z=X;
dim=size(Sample);
Y=cell(2,1);
Y{1}=zeros(dim);
Y{2}=zeros(dim);
N=ndims(Sample);
Ysum=zeros(dim);
tic
for k=1: 200
    %k=1: maxiter
    Ysum=0*Ysum;
  for i=1:N
      Mat=ten2mat(X,dim,i);
      mode(i)=trace(sqrtm(Mat*Mat'));
  end
[Min, mi]=min(mode);
[Max, ma]=max(mode);


%update Z
%G1=X+lambda*Y{1};
G1=X+0.5*lambda*Z1/norm(Z1(:))+lambda*Y{1};
Z1=mat2ten(Pro2TraceNorm(ten2mat(G1, dim, mi), lambda/(2*(1+epsilon1)^(1/2))), dim, mi);

%G2=X+lambda*Y{2};
G2=X+0.5*lambda*Z2/norm(Z2(:))+lambda*Y{2};
Z2=mat2ten(Pro2TraceNorm(ten2mat(G2, dim, ma), lambda/(2*(1+epsilon1)^(1/2))), dim, ma);

%update X
Z=0.5*(Z1+Z2);
Ysum=0.5*(Y{1}+Y{2});
UX=X;
X=(Z-lambda*Ysum);
X(Omega)=Sample(Omega);

%update Y
Y{1}=Y{1}+(1/lambda)*(X-Z1);
Y{2}=Y{2}+(1/lambda)*(X-Z2);


R=norm(X(:)-UX(:))/norm(UX(:));
 if   k==200
     %R>0 && R<epsilon 
     break
 else 
    lambda=miu*lambda;
 end
end
time=toc;
X_hat=X;
%RSE =norm(X(:)-Original(:),'fro')/norm(Original(:),'fro');
Q=norm(X(:)-Original(:),'fro')^2;
PSNR=10*log10(dim(1)*dim(2)*dim(3)/Q);
for i1=1:dim(3)
    J0=Original(:,:,i1);
    I0=X(:,:,i1);
    SSIMvec0(1,i1)=ssim3(J0*255,I0*255);
end
SSIM=mean(SSIMvec0);
fprintf('ADMMEF Iter %d\n',k)
fprintf('ADMMEF CPU  %8.4f\n',time)
%fprintf('ADMMEF RSE %e\n',RSE)
fprintf('ADMMEF PSNR  %8.2f\n',PSNR)
fprintf('ADMMEF SSIM  %8.4f\n',SSIM)
end
