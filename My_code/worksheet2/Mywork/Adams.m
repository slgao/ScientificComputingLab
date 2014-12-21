function y=Adams(f,y0,dt,tend)
y(1)=y0;
for i=1:tend/dt
    G=@(m)(m-y(i)-(1/2)*dt*(f(m)+f(y(i))));
    Gd=@(m)(1+7*dt/10*m-7/2*dt);
    x(1)=y(i);
    j=1;
    x(j+1)=x(j)-G(x(j))/Gd(x(j));
    j=2;
    while abs(x(j)-x(j-1))>=10^-4
        prev=x(j);
        x(j+1)=x(j)-G(x(j))/Gd(x(j));
        new=x(j+1);
        err=new-prev;
        if abs(err/(x(j)-x(j-1)))>1
            error('unsolvable equation');
        end
        j=j+1;
    end
    y(i+1)=new;
end