function [N]=sample(M,p)
dim=size(M);
n=ndims(M);
q=1;
for i=1:n
q=q*dim(i);
end
N=zeros(size(M));
V=round(p*q);
y=randsample(q,V);
for i=1:V
    m=y(i);
    N(m)=M(m);
end
end