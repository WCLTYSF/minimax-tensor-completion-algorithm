%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADM algorithm: tensor completion

function [RSE,time,k] = Adm(X,obs)
Omega=logical(X);
beta=1;
sigma=0.1;
maxIter=1000;
epsilon=1e-05;
dim = size(X);
N=ndims(X);
lemda=1000;
W=cell(ndims(X),1);
Y=W;
k=0;
I=eye(X);
for i = 1:N
    W{i} = zeros(dim);
    Y{i}= zeros(dim);    
end
Wsum = zeros(dim);
Ysum = zeros(dim);
tic
for k = 1: maxIter
    Wsum = 0*Wsum;
    Ysum = 0*Ysum;
 for i=1:N  
  %update Y
       Y{i}=mat2ten(Pro2TraceNorm(ten2mat(X-W{i}/beta, dim, i), 1/beta), dim, i); 
%update W
        W{i}=W{i}-beta*(X-Y{i});
        Wsum = Wsum + W{i};
         Ysum = Ysum + Y{i}; 
     end
        %update x  
        LastX=X;
%      n=ndims(X)-1/(rho*norm(X(:),'fro'));  
             
          Omega.*X =(Wsum+Ysum*beta+lemda*Omega.*(obs))/(lemda*I+N*beta*I); 
          (1-Omega).*X=(Wsum+Ysum*beta)/(N*beta*I);     
           X= Omega.*X+(1-Omega).*X;
       

    
else
       LastX
           k=k+1;
     R=norm(X(:)-LASTX(:))/norm(X(:));
     if R>0 && R<epsilon;
        break
     else
        beta=beta*2;
  v=Omega.*(X)-Omega.*(obs);  
  lemda=lemda*(sigma)/norm(v(:));
     end
end
time=toc;    
    RSE=norm(X(:)-obs(:))/norm(obs(:));
fprintf('Adm Iter %d\n',k)
fprintf('Adm CPU  %8.4f\n',time)
fprintf('Adm RSE %e\n',RSE)
end