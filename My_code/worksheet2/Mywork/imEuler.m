function y=imEuler(f,y0,dt,tend)
y(1)=y0;
for i=1:tend/dt
    G=@(m)(m-y(i)-dt*f(m));
    Gd=@(m)(7*dt/5*m+1-7*dt);
    x(1)=y(i);
    j=1;
    x(j+1)=x(j)-G(x(j))/Gd(x(j));
    j=2;
    while abs(x(j)-x(j-1))>=10^-4
        x(j+1)=x(j)-G(x(j))/Gd(x(j));
        xf=x(j+1);
        j=j+1;
    end
    y(i+1)=xf;
end