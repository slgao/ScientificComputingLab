% using implicit euler method to plot the animation
clear all;
Nx=7;
dt=1/256;
t=1;
figure;
set(gcf,'color','w');
set(gcf,'Renderer','ZBuffer');
T=zeros(1,Nx^2)+1;
for l=1:t/dt
Tnext=im_Euler(Nx,Nx,dt,T);
T=Tnext;
% transfer T vector to M matrix
 M=zeros(Nx+2,Nx+2);
for m=1:Nx^2
    if mod(m,Nx)~=0
        M(mod(m,Nx)+1,(m-mod(m,Nx))/Nx+2)=T(m);
    else
        M(Nx+1,m/Nx+1)=T(m);
    end
end
%%%%%%%%%%%%%%%%%%
% plot the matrix into surface
x=0:1/(Nx+1):1;y=0:1/(Nx+1):1;
% c1=colormap('winter');
% c2=colormap('hot');
% c3=p*c1+(1-p)*c2;
% colormap(c3);
mesh(y,x,M);
%%%%%%%%%%%%%%%%%%
axis([0 1 0 1 0 1]);
pause(.2);
 end