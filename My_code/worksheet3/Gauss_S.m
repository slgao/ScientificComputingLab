function [M_T,t,T,e,iteration]=Gauss_S(Nx,Ny,b)
% b=@(x,y)(sin(pi*x)*sin(pi*y));
% Nx=31;Ny=31;
D=Nx*Ny;
T=zeros(1,D);
hx=1/(Nx+1);
hy=1/(Ny+1);
x=hx:hx:1-hx;
y=hy:hy:1-hy;
c=2*(hx^2+hy^2);
R=1;iteration=0;
k=1;
tic;
while (R(k)>1e-4)
    index=[1,1];
    sum1=0;
    iteration=iteration+1;
for i=1:D
    t1=0;t2=0;t3=0;t4=0;
%     FR=2*pi^2*hx^2*hy^2*sin(pi*x(index(1)))*sin(pi*y(index(2)));
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
        index(2)=index(2)+1;end
    end
end
% transfer one step T into a matrix
M_T=zeros(Nx+2,Ny+2);
for j=1:D
    m=mod(j,Nx);
    if m==0
    M_T(Nx+1,(j-m)/Nx+1)=T(j);
    else M_T(m+1,(j-m)/Nx+2)=T(j);
    end
end
%%%%%%%%%%%%%%%%
%surf the one step matrix
% % pause(.05);
X=0:hx:1;
Y=0:hy:1;
surf(Y,X,M_T);
tt=toc;
title(['the time is: ', num2str(tt)]);
set(gcf,'color','w');
axis([0 1 0 1 0 1]);
k=k+1;
R(k)=sqrt(1/D*sum1)/(hx^2*hy^2);
% % % % % % % temp=0;
% % % % % % % index=[1,1];
% % % % % % % for j=1:Nx*Ny
% % % % % % %     b_a=M(j,:)*T';
% % % % % % %     Fr=-2*pi^2*hx^2*hy^2*sin(pi*x(index(1)))*sin(pi*y(index(2)));
% % % % % % %     temp=temp+(Fr-b_a)^2;
% % % % % % %     index(1)=index(1)+1;
% % % % % % %    if index(1)>Nx
% % % % % % %         if index(2)<Ny
% % % % % % %         index(1)=1;
% % % % % % %         index(2)=index(2)+1;end
% % % % % % %     end
% % % % % % % end
% % % % % % % k=k+1;
% % % % % % % R(k)=sqrt((1/(Nx*Ny))*temp)
end
t=toc;
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
%%%%%%%%%%%%%%%%%%
% calculating the error of the real and Gauss_Seidel
e=sqrt(1/D*sum((T-T_R).^2));
%%%%%%%%%%%%%%%%%