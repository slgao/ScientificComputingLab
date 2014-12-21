function y=Heun(f,y0,dt,tend)
y(1)=y0;
for i=1:tend/dt
    T=y(i)+dt*f(y(i));
    y(i+1)=y(i)+1/2*dt*(f(T)+f(y(i)));
end