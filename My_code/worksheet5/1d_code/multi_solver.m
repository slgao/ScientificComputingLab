function [T,t,R]=multi_solver(N)
% solving the right hand side as a vector
b=@(x,y)(sin(pi*x));

h=1/(N+1);
x=h:h:1-h;
FR=zeros(N,1);
for i=1:N
    FR(i)=-2*pi^2*b(x(i));
end
%%%%%%%%%%%%%%%%%

T=ones(1,N);R=1;
tic;
global itera
itera=0;
while(R>1e-8)
T=v_cycle(T,FR,N);
res=RES_multi(N,FR,T);
R=sqrt(sum(res.^2)/N);  
end
t=toc;
disp(['When Nx=Ny= ',num2str(N),10,'# ierations: ',num2str(itera)...
    ,10,'the runtime is: ',num2str(t),' seconds',10]);
