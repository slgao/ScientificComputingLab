function y=expEuler(f,y0,dt,tend)
y(1)=y0;
for i=1:tend/dt
    y(i+1)=y(i)+dt*f(y(i));
end