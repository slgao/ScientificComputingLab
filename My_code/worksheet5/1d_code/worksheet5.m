clear all;
method=3;
% a=[3,7,15,31,63,127,255,511,1023,2047,4095,8191,16383];
a=[3,31];
b=@(x,y)(sin(pi*x)*sin(pi*y));


if (method==1)
% calculate the iteration number and time for classic Gauss-Seidel iteration
n=0;
for i=1:length(a)
Nx=a(i);Ny=Nx;
[e1,t1,iteration1]=Gauss_S(Nx,Ny,b,n);
end

% plot the error after 10,20,30 iterations for Gauss-Seidel 
n=1;
Nx=255;Ny=Nx;
[e2,t2,iteration2]=Gauss_S(Nx,Ny,b,n);


elseif(method==2)
% calculate the iteration number and time for SOR
b=@(x,y)(sin(pi*x)*sin(pi*y));
for j=1:length(a)
Nx=a(j);Ny=Nx;
[T2,t2,iteration2]=SOR(Nx,Ny,b);
end

% transfer T2 into a matrix
M_T=zeros(Nx+2,Ny+2);
for j=1:Nx*Ny
    m=mod(j,Nx);
    if m==0
    M_T(Nx+1,(j-m)/Nx+1)=T2(j);
    else M_T(m+1,(j-m)/Nx+2)=T2(j);
    end
end

%surf the matrix which is the finest grid
hx=1/(Nx+1);hy=1/(Ny+1);
X=0:hx:1;
Y=0:hy:1;
figure;
h=surf(Y,X,M_T);
set(h,'LineStyle','none');
title('the finest grid Nx=Ny=255 using SOR method ');xlabel('x');ylabel('y');
set(gcf,'color','w');
axis([0 1 0 1 0 1]);


else
% multigrid method to calculate 
for i=1:length(a)
N=a(i);
[Ta,t,R]=multi_solver(N);
end
% % transfer Ta into a matrix
% M_T=zeros(Nx+2,Ny+2);
% for j=1:Nx*Ny
%     m=mod(j,Nx);
%     if m==0
%     M_T(Nx+1,(j-m)/Nx+1)=Ta(j);
%     else M_T(m+1,(j-m)/Nx+2)=Ta(j);
%     end
% end


%surf the matrix which is the finest grid
h=1/(N+1);
X=h:h:1-h;
figure;
plot(X,Ta);
% set(h,'LineStyle','none');
title('the finest grid Nx=255 using multigrid method ');xlabel('x');
set(gcf,'color','w');
end