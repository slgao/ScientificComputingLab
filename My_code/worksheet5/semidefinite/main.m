clear all;
method=2;
l=5;num_relax=3;
N=2^l-1;
M=2^(l-1)-1;
h=1/(N+1);
L=(diag(ones(N-1,1),1)+diag(-2*ones(N,1))+diag(ones(N-1,1),-1))/h^2;
R=zeros(M,N);
for m=1:M
    
  R(m,1+2*(m-1))=1/4;
  R(m,2+2*(m-1))=1/2;
  R(m,3+2*(m-1))=1/4;
   
end

P=2*R';
LE11=R*L*P;
LE12=R*L;
LE21=L*P;
LE22=L;
LE1=cat(2,LE11,LE12);
LE2=cat(2,LE21,LE22);
LE=cat(1,LE1,LE2);
x=h:h:1-h;
Fk=zeros(1,N);
for i=1:N
Fk(i)=-2*pi^2*sin(x(i));
end
Fk=Fk';
FE1=R*Fk;
FE=cat(1,FE1,Fk);
res=1;
iter=0;
w1=zeros(M,1);
w2=zeros(N,1);
I=eye(N);
SE=cat(2,P,I);
if method==1
tic;
while(res>1e-4)


    
for i=1:N
    sum_1=0;sum_2=0;
    if i>1
    for j=1:i-1
        sum_1=sum_1+L(i,j)*w2(j);
    end
    end
    if i<N
    for j=i+1:N
        sum_2=sum_2+L(i,j)*w2(j);
    end
    end
    
    w2(i)=(Fk(i)-sum_1-sum_2)/L(i,i);
end
r=Fk-L*w2;
res=norm(r)/sqrt(N);
iter=iter+1;
end
iter 
t=toc
plot(x,w2)

else
    tic;
while(res>1e-4)

% for k=1:num_relax
    
for i=1:N
    sum1=0;sum2=0;
    if i>1
    for j=1:i-1
        sum1=sum1+L(i,j)*w2(j);
    end
    end
    if i<N
    for j=i+1:N
        sum2=sum2+L(i,j)*w2(j);
    end
    end
    r1=Fk(i)-LE21*w1;
    w2(i)=(r1(i)-sum1-sum2)/L(i,i);
end
iter=iter+1;
% end
% for l=1:num_relax
for i=1:M
    sum3=0;sum4=0;
    if i>1
    for j=1:i-1
        sum3=sum3+LE11(i,j)*w1(j);
    end
    end
    if i<M
    for j=i+1:M
        sum4=sum4+LE11(i,j)*w1(j);
    end
    end
    r2=FE1(i)-LE12*w2(i);
    w1(i)=(r2(i)-sum3-sum4)/LE11(i,i);
end
% end
w=cat(1,w1,w2);
u=SE*w;
r=Fk-L*u;
res=norm(r)/sqrt(N);
iter=iter+1;
end
iter
t=toc
plot(x,u)
end




