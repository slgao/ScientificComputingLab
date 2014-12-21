function y = expEuler(f,y0,dt,tend)

% expEuler(f,y0,dt,tend). Calculates the solution of the differential
% equation y' = f(y) with y(0) = y0 using the explicit Euler method. f is a
% handle to the function f(y); y0 is the initial value of the function; dt
% is the timestep; tend is the final time.

tic
Tn = tend./dt;
t = 0:dt:tend;
y(1) = y0;

for j=2:Tn+1
    y(j) = y(j-1)+dt*f(y(j-1));
end
tE=toc;