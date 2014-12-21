function y = adMoLin(f,y0,dt,tend,lin)

% adMoLin(f,y0,dt,tend,lin). Calculates the solution of the differential
% equation y' = f(y) with y(0) = y0 using two linearizations of the 
% Adams-Moulton method. f is a handle to the function f(y); 
% y0 is the initial value of the function; dt is the timestep; 
% tend is the final time. lin is the type of linearization to be used,
% according to the worksheet (1 or 2).

tic
Tn = tend./dt;
t = 0:dt:tend;
y(1) = y0;
method = 2;

% First method: Solves the linear equation explicitly
if(method==1)
    if(lin==1)
        for j=2:Tn+1
            y(j) = y(j-1)*(1+7*dt*(1-y(j-1)/20))/(1+7*dt*y(j-1)/20);
        end
        t = toc;
    end
    if(lin==2)
        for j=2:Tn+1
            y(j) = y(j-1)*(1+(7*dt/2)*(1-y(j-1)/10))/(1-(7*dt/2)*(1-y(j-1)/10));
        end
        t = toc;
    end
end

%Second method: Use Newton's method for every timestep
if(method==2)
    syms y1 y2 ys;
    fs = f(y1,y2);         %Make the function handle a symbolic function

    for j=2:Tn+1
        tol = 1e-4;
        ERR = Inf;                                              %Initial error for Newton's method    
        y(j) = y(j-1);                                          %Initial guess for the y(j) value
        f1 = subs(fs,[y1,y2],[y(j-1),y(j-1)]);
        if(lin==1) f2 = subs(fs,y2,y(j-1)); end
        if(lin==2) f2 = subs(fs,y1,y(j-1)); end
        F = ys - y(j-1) - (dt/2)*(subs(f1,ys) + subs(f2,ys)); %Adams-Moulton function for Newton's method
        dF = diff(F,ys);                            %Its derivative
        while(ERR>tol)
            yprev = y(j);
            y(j) = yprev-subs(F,yprev)/subs(dF,yprev);
            if(abs(abs(y(j)-yprev)/ERR)>10) error('The error is growing. Cannot solve the equation.'); end
            ERR = abs(y(j)-yprev);
        end
    end
    tE=toc;
end