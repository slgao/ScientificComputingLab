T=[1 1/2 1/4 1/8];
y0=1;tend=5;
for i=1:4
h=T(i);   
pk=yapp_euler(y0,h,tend);
p1=yapp_euler(y0,1/8,tend);
k=0;
while 1+8*h*k<=41
pbest(k+1)=p1(1+8*h*k);
k=k+1;
end
E(i)=sqrt(h/5*sum((pk-pbest).^2));% There is a doubt here. E(i)  If there is no ;
end