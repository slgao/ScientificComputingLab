function ya=yapp_euler(y0,h,tend)
ya(1)=y0;
for i=1:tend/h
k=(1-ya(i)/10)*ya(i);
ya(i+1)=ya(i)+h*k;
end
t=0:h:tend;
p=10./(1+9*exp(-t));
plot([0:h:tend],ya,'b',t,p,'r--');
