function [T,t,R]=multi_solver(Nx,Ny)
% solving the right hand side as a vector
D=Nx*Ny;
b=@(x,y)(sin(pi*x)*sin(pi*y));
index=[1,1];
hx=1/(Nx+1);
hy=1/(Ny+1);
x=hx:hx:1-hx;
y=hy:hy:1-hy;
memory=8/3*((Nx+1)*(Ny+1)-4);
for i=1:D
    FR(i)=-2*pi^2*b(x(index(1)),y(index(2)));
    index(1)=index(1)+1;
    if index(1)>Nx
        if index(2)<Ny
            index(1)=1;
            index(2)=index(2)+1;
        end
    end
end
%%%%%%%%%%%%%%%%%
D=Nx*Ny;
T=ones(1,D);R=1;
tic;
global itera
itera=0;
while(R>1e-4)
T=v_cycle(T,FR,Nx,Ny);
res=RES_multi(Nx,Ny,FR,T);
R=sqrt(sum(res.^2)/D);  
end
t=toc;
disp(['When Nx=Ny= ',num2str(Nx),10,'# ierations: ',num2str(itera)...
    ,10,'the runtime is: ',num2str(t),' seconds',10,'the memory cost is: '...
    ,num2str(memory),10]);
