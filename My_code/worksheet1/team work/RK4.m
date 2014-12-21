function y = RK4(f,y0,dt,tend)

% Heun(f,y0,dt,tend). Calculates the solution of the differential
% equation y' = f(y) with y(0) = y0 using the Runge-Kutta order 4 method. 
% f is a handle to the function f(y); y0 is the initial value of the 
% function; dt is the timestep; tend is the final time.

tic
Tn = tend/dt;
t = 0:dt:tend;
y(1) = y0;

for j=1:Tn
    y1 = dt*f(y(j));
    y2 = dt*f(y(j)+y1/2);
    y3 = dt*f(y(j)+y2/2);
    y4 = dt*f(y(j)+y3);
    y(j+1) = y(j) + (y1 + 2*y2 + 2*y3 + y4)/6;
end
tRK = toc;