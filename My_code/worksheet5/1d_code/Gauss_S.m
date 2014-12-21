function [e,t,iteration]=Gauss_S(Nx,Ny,b,n)
D=Nx*Ny;
T=ones(1,D);
hx=1/(Nx+1);
hy=1/(Ny+1);
x=hx:hx:1-hx;
y=hy:hy:1-hy;
c=2*(hx^2+hy^2);
R=1;iteration=0;ite=[10,20,30];
% calculating the real value of the Tem%
index=[1,1];
for l=1:D
T_R(l)=b(x(index(1)),y(index(2)));
index(1)=index(1)+1;
    if index(1)>Nx
        if index(2)<Ny
        index(1)=1;
        index(2)=index(2)+1;
        end
    end
end

% calculate the T and error after 10,20,30 Gauss-Seidel iterations
if (n~=0)
for k=1:length(ite)
tic;
while (iteration<=ite(k))
    index=[1,1];
    iteration=iteration+1;
for i=1:D
    t1=0;t2=0;t3=0;t4=0;
    FR=2*pi^2*hx^2*hy^2*b(x(index(1)),y(index(2)));
    if mod(i,Nx)~=0 
       t1=hy^2*T(i+1);end
    if mod(i-1,Nx)~=0 
       t2=hy^2*T(i-1);end
    if i-Nx>0
        t3=hx^2*T(i-Nx);end
    if i+Nx<=Nx*Ny 
        t4=hx^2*T(i+Nx);end
    T(i)=(FR+t1+t2+t3+t4)/c;
    index(1)=index(1)+1;
    if index(1)>Nx
        if index(2)<Ny
        index(1)=1;
        index(2)=index(2)+1;
        end
    end
end
end
t=toc;
% calculating the error of the real and Gauss_Seidel
e=T-T_R;


% transfer e into a matrix
M_T=zeros(Nx+2,Ny+2);
for j=1:Nx*Ny
    m=mod(j,Nx);
    if m==0
    M_T(Nx+1,(j-m)/Nx+1)=e(j);
    else M_T(m+1,(j-m)/Nx+2)=e(j);
    end
end


% plotting the error
subplot(1,length(ite),k);
xx=0:hx:1;yy=0:hy:1;
imagesc(yy,xx,M_T);
title(['Gauss-Seidel iteration= ',num2str(ite(k))]);xlabel('x');ylabel('y');
set(gcf,'color','w');colorbar;
end
    
% calculate the classic Gauss-Seidel util the residual norm criteria is reached  
elseif(n==0)
    memory=Nx*Ny;
    tic;
while (R>1e-4)
    index=[1,1];
    sum1=0;
    iteration=iteration+1;
for i=1:D
    t1=0;t2=0;t3=0;t4=0;
    FR=2*pi^2*hx^2*hy^2*b(x(index(1)),y(index(2)));
    if mod(i,Nx)~=0 
       t1=hy^2*T(i+1);end
    if mod(i-1,Nx)~=0 
       t2=hy^2*T(i-1);end
    if i-Nx>0
        t3=hx^2*T(i-Nx);end
    if i+Nx<=Nx*Ny 
        t4=hx^2*T(i+Nx);end
    sum1=sum1+(t1+t2+t3+t4-c*T(i)+FR)^2;
    T(i)=(FR+t1+t2+t3+t4)/c;
    index(1)=index(1)+1;
    if index(1)>Nx
        if index(2)<Ny
        index(1)=1;
        index(2)=index(2)+1;
        end
    end
end
R=sqrt(1/D*sum1)/(hx^2*hy^2);
% calculating the error of the real and Gauss_Seidel
e=T-T_R;
end
t=toc;
disp(['When Nx=Ny= ',num2str(Nx),10,'# iterations: ',num2str(iteration),...
    10,'runtime is: ',num2str(t),' seconds',10,'memory is: ',num2str(memory),10 ]);
end