function y=yapp_runge(y0,h,tend)
p(1)=y0;
for i=1:tend/h
k1=(1-p(i)/10)*p(i);
k2=(1-(p(i)+h/2*k1)/10)*(p(i)+h/2*k1);
k3=(1-(p(i)+h/2*k2)/10)*(p(i)+h/2*k2);
k4=(1-(p(i)+h*k3)/10)*(p(i)+h*k3);
p(i+1)=p(i)+1/6*h*(k1+2*k2+2*k3+k4);
end
y=p;
t=0:h:tend;
p=10./(1+9*exp(-t));
plot(linspace(0,tend,tend/h+1),p,'g',t,p,'r--')