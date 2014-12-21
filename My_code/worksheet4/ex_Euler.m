function Tnext=ex_Euler(Nx,Ny,dt,T)
% clear all;
% Nx=7;Ny=7;dt=1/64;t=1/16;
D=Nx*Ny;
% T=zeros(1,D)+1;
hx=1/(Nx+1);
hy=1/(Ny+1);
a1=dt/hx^2; a2=dt/hy^2; a3=1-2*dt/hx^2-2*dt/hy^2;
% for j=1:t/dt
for i=1:D
    t1=0; t2=0; t3=0; t4=0; t5=a3*T(i);
    if mod(i-1,Nx)~=0 t1=a1*T(i-1); end
    if mod(i,Nx)~=0 t2=a1*T(i+1); end
    if i-Nx>0 t3=a2*T(i-Nx); end
    if i+Nx<=D t4=a2*T(i+Nx); end
    Tnext(i)=t1+t2+t3+t4+t5;
end
% % T=Tnext;
% % end
% % transfer the T vector to M matrix
% M=zeros(Nx+2,Ny+2);
% for k=1:D
%     if mod(k,Nx)~=0
%         M(mod(k,Nx)+1,(k-mod(k,Nx))/Nx+2)=T(k);
%     else
%         M(Nx+1,k/Nx+1)=T(k);
%     end
% end
% %%%%%%%%%%%%%%%%%%
% % plot the matrix into surface
% x=0:hx:1;y=0:hy:1;
% mesh(y,x,M);











