%sparse or normal matrix ---direct solver
clear all;
Nx=7;Ny=7;
D=Nx*Ny;
M=C_matrix(Nx,Ny);
M=sparse(M);
index=[1,1];
hx=1/(Nx+1);
hy=1/(Ny+1);
x=hx:hx:1-hx;
y=hy:hy:1-hy;
b=@(x,y)(sin(pi*x)*sin(pi*y));
for i=1:Nx*Ny
    B(i)=-2*pi^2*hx^2*hy^2*b(x(index(1)),y(index(2)));
     index(1)=index(1)+1;
    if index(1)>Nx
        if index(2)<Ny
        index(1)=1;
        index(2)=index(2)+1;end
    end
end 
tic;
T=M\B';
t1=toc;
%transfer the T to the matrix%
M_T=zeros(Nx+2,Ny+2);
for j=1:D
    m=mod(j,Nx);
    if m==0
    M_T(Nx+1,(j-m)/Nx+1)=T(j);
    else M_T(m+1,(j-m)/Nx+2)=T(j);
    end
end
% Visulisation of the direct solver%
X=0:hx:1;
Y=0:hy:1;
subplot(1,2,1);
surf(Y,X,M_T);
set(gcf,'units','normalized','outerposition',[0 0 1 1],'color','w');
axis([0 1 0 1 0 1]);
% Visulisation of the Gauss_Seidel solver(just one final M_T)%
% b=@(x,y)(sin(pi*x)*sin(pi*y));
% [G,t]=Gauss_S(7,7,b);
% X=0:hx:1;
% Y=0:hy:1;
% subplot(2,2,2);
% surf(Y,X,G);
% set(gcf,'color','w');
% axis([0 1 0 1 0 1]);
%%%%%%%%%%%%%%%
% contour of the 3D figure%
subplot(1,2,2);
contour(Y,X,M_T);
colorbar;
%%%%%%%%%%%%%%%%
%plot the Gauss_Seidel solver and contour the 3D figure (use pause to generate animation)
figure;
set(gcf,'units','normalized','outerposition',[0 0 1 1],'color','w');
subplot(1,2,1);
b=@(x,y)(sin(pi*x)*sin(pi*y));
 [G,t,T,e,iteration]=Gauss_S(Nx,Ny,b)
subplot(1,2,2);
contour(Y,X,G);
colorbar;
%%%%%%%%%%%%%%%%


