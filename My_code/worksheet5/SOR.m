function [T,t,iteration]=SOR(Nx,Ny,b)
% b=@(x,y)(sin(pi*x)*sin(pi*y));
% Nx=63;Ny=63;
D=Nx*Ny;
T=ones(1,D);
hx=1/(Nx+1);
hy=1/(Ny+1);
x=hx:hx:1-hx;
y=hy:hy:1-hy;
c=-2*(hx^2+hy^2);
R=1;iteration=0;
j=1;
w=2/(1+sin(pi*hx));
memory=Nx*Ny;
% calculating the real value of the Tem%
index=[1,1];
for l=1:D
T_R(l)=b(x(index(1)),y(index(2)));
index(1)=index(1)+1;
    if index(1)>Nx
        if index(2)<Ny
        index(1)=1;
        index(2)=index(2)+1;end
    end
end


tic;
while (R>1e-4)
    index=[1,1];
    sum1=0;
    iteration=iteration+1;
for i=1:D
    t1=0;t2=0;t3=0;t4=0;
    FR=-2*pi^2*hx^2*hy^2*b(x(index(1)),y(index(2)));
    if mod(i,Nx)~=0 
       t1=hy^2*T(i+1);end
    if mod(i-1,Nx)~=0 
       t2=hy^2*T(i-1);end
    if i-Nx>0
        t3=hx^2*T(i-Nx);end
    if i+Nx<=Nx*Ny 
        t4=hx^2*T(i+Nx);end
    sum1=sum1+(t1+t2+t3+t4+c*T(i)-FR)^2;
    T(i)=w*(FR-t2-t3-t1-t4-c*T(i))/c+T(i);
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
e(j)=sqrt(1/D*sum((T-T_R).^2));
j=j+1;
%%%%%%%%%%%%%%%%%
end
t=toc;
%display information
disp(['When Nx=Ny= ',num2str(Nx),10,'# iterations: ',num2str(iteration),...
    10,'runtime is: ',num2str(t),' seconds',10,'memory is: ',num2str(memory),10 ]);