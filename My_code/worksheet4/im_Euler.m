function Tnext=im_Euler(Nx,Ny,dt,T)
% clear all;
% Nx=3;Ny=3;dt=1/64;
% T=zeros(1,D)+1;
D=Nx*Ny;
hx=1/(Nx+1);
hy=1/(Ny+1);
Tnext=zeros(1,D);
a=1/(1+2*dt*(1/hx^2+1/hy^2));
m=dt/hx^2;n=dt/hy^2;
R=1;k=0;
while(R>1e-4)
    sum1=0;
for i=1:D
    t1=0; t2=0; t3=0; t4=0;
    if mod(i-1,Nx)~=0 t1=m*Tnext(i-1); end
    if mod(i,Nx)~=0 t2=m*Tnext(i+1); end
    if i-Nx>0 t3=n*Tnext(i-Nx); end
    if i+Nx<=D t4=n*Tnext(i+Nx); end
    sum1=sum1+(1/a*Tnext(i)-T(i)-t1-t2-t3-t4)^2;
    Tnext(i)=a*(T(i)+t1+t2+t3+t4);
end
k=k+1;
% % % calculating the residual norm 
% % sum1=0;
% % for j=1:D   
% %     t1=0; t2=0; t3=0; t4=0;
% %     if mod(i-1,Nx)~=0 t1=m*T(i-1); end
% %     if mod(i,Nx)~=0 t2=m*T(i+1); end
% %     if i-Nx>0 t3=n*T(i-Nx); end
% %     if i+Nx<=D t4=n*T(i+Nx); end
% %     sum1=sum1+(1/a*TT(i)-T(i)-t1-t2-t3-t4)^2;
% % end
% % %%%%%%%%%%%%%%%%
R=sqrt(1/D*sum1);
end
    




