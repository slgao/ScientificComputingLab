function y=Linear2(y0,dt,tend)
y(1)=y0;
for i=1:tend/dt
    G=@(m)(y(i)+dt/2*(7*y(i)-7/10*y(i)^2+7*m-7/10*y(i)*m)-m);
    Gd=@(m)(dt/2*(7-7/10*y(i))-1);
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