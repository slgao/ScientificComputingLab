function res=RES_multi(Nx,Ny,FR,T)
% b=@(x,y)(sin(pi*x)*sin(pi*y));
% Nx=63;Ny=63;
D=Nx*Ny;
hx=1/(Nx+1);
hy=1/(Ny+1);
% x=hx:hx:1-hx;
% y=hy:hy:1-hy;
c=-2*(1/hx^2+1/hy^2);
% index=[1,1];
for i=1:D
    t1=0;t2=0;t3=0;t4=0;
%     FR=-2*pi^2*b(x(index(1)),y(index(2)));
    if mod(i,Nx)~=0 
       t1=T(i+1)/hx^2;end
    if mod(i-1,Nx)~=0 
       t2=T(i-1)/hx^2;end
    if i-Nx>0
        t3=T(i-Nx)/hy^2;end
    if i+Nx<=Nx*Ny 
        t4=T(i+Nx)/hy^2;end
    res(i)=-(t1+t2+t3+t4+c*T(i)-FR(i));
%     index(1)=index(1)+1;
%     if index(1)>Nx
%         if index(2)<Ny
%         index(1)=1;
%         index(2)=index(2)+1;end
%     end
end