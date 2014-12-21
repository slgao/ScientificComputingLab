function y=yapp_heun(y0,h,tend)
p(1)=y0;
for i=1:tend/h
k=(1-p(i)/10)*p(i);
p_in=p(i)+h*k;
p(i+1)=p(i)+1/2*h*(k+(1-p_in/10)*p_in);
end
y=p;
%t=0:h:tend;
%p=10./(1+9*exp(-t));
%plot(linspace(0,tend,tend/h+1),p,'c',t,p,'r--')