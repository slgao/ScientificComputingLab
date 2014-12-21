clear all
% the plot for explicit Euler method
Nx=[3,7,15,31];
dt=[1/64,1/128,1/256,1/512,1/1024,1/2048,1/4096];
t=[1/8,2/8,3/8,4/8];
for k=1:length(t)
figure;
set(gcf,'units','normalized','outerposition',[0 0 1 1],'color','w',...
    'Renderer','ZBuffer');
% annotation('textbox',[0 0.5 0.1 0.1],'string',['ggggggg']);
for j=1:length(Nx)
for i=1:length(dt)
    subplot(length(Nx),length(dt),i+(j-1)*7);
     T=ones(1,Nx(j)^2);
     for l=1:t(k)/dt(i)
    Tnext=ex_Euler(Nx(j),Nx(j),dt(i),T);
    T=Tnext;
     end
% transfer T vector to M matrix
     M=zeros(Nx(j)+2,Nx(j)+2);
for m=1:Nx(j)^2
    if mod(m,Nx(j))~=0
        M(mod(m,Nx(j))+1,(m-mod(m,Nx(j)))/Nx(j)+2)=T(m);
    else
        M(Nx(j)+1,m/Nx(j)+1)=T(m);
    end
end
%%%%%%%%%%%%%%%%%%
% plot the matrix into surface
x=0:1/(Nx(j)+1):1;y=0:1/(Nx(j)+1):1;
mesh(y,x,M);
title(['dt=1/',num2str(2^(5+i))]);
%%%%%%%%%%%%%%%%%%
end
end
end
%%%%%%%%%%%%%%%%%%



% plot the implicit method
Nx=[3,7,15,31];
dt=1/64;
t=[1/8,2/8,3/8,4/8];
for k=1:length(t)
    figure;
for j=1:length(Nx)
    subplot(1,4,j);
    set(gcf,'units','normalized','outerposition',[0 .5 1 .5],'color','w');
    set(gcf,'Renderer','ZBuffer');
    T=ones(1,Nx(j)^2);
    for l=1:t(k)/dt
    Tnext=im_Euler(Nx(j),Nx(j),dt,T);
    T=Tnext;
    end
% transfer T vector to M matrix
     M=zeros(Nx(j)+2,Nx(j)+2);
for m=1:Nx(j)^2
    if mod(m,Nx(j))~=0
        M(mod(m,Nx(j))+1,(m-mod(m,Nx(j)))/Nx(j)+2)=T(m);
    else
        M(Nx(j)+1,m/Nx(j)+1)=T(m);
    end
end
%%%%%%%%%%%%%%%%%%
% plot the matrix into surface
x=0:1/(Nx(j)+1):1;y=0:1/(Nx(j)+1):1;
mesh(y,x,M);
%%%%%%%%%%%%%%%%%%
end
end