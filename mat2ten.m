function ten=mat2ten(mat,dim,k)
dim0=[([dim(1:k-1),dim(k+1:length(dim))]),dim(k)];
ten=permute(reshape(mat',dim0),[1:k-1,length(dim),k:length(dim)-1]);