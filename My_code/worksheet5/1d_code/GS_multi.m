function T=GS_multi(N,FR,T)
% b=@(x,y)(sin(pi*x)*sin(pi*y));
% Nx=63;Ny=63;

h=1/(N+1);

% x=hx:hx:1-hx;
% y=hy:hy:1-hy;
c=-2*1/h^2;
iteration=0;ite=2;
global itera;          % global counter
while (iteration<ite)
%     index=[1,1];
    itera=itera+1;
    iteration=iteration+1;
for i=1:N
    t1=0;t2=0;
%     FR=2*pi^2*hx^2*hy^2*sin(pi*x(index(1)))*sin(pi*y(index(2)));
%     FR=-2*pi^2*b(x(index(1)),y(index(2)));
if mod(i,N)~=0 
       t1=T(i+1)/h^2;end
    if mod(i-1,N)~=0 
       t2=T(i-1)/h^2;end
    
    T(i)=(FR(i)-t1-t2)/c;
%     index(1)=index(1)+1;
%     if index(1)>Nx
%         if index(2)<Ny
%         index(1)=1;
%         index(2)=index(2)+1;end
%     end
end
end