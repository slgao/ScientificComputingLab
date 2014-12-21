T=[1 1/2 1/4 1/8];
y0=1;tend=5;
for i=1:4
h=T(i);   
pk=yapp_heun(y0,h,tend);
t=0:h:tend;
pexact=10./(1+9*exp(-t));
E(i)=sqrt(h/5*sum((pk-pexact).^2));% There is a doubt here. E(i)  If there is no ;
if i==4
    break
end
figure;
end