clear all
tend = 5;
dt = .01;
Tn = tend/dt;
t = linspace(0,tend,Tn);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exact solution
pEx = 10./(1+9*exp(-t));
% figure(1)
subplot(2,2,1)
hold on
plot(t,pEx,'Color','k'); set(gcf,'Color','w');
title('Plot of the exact solution p(t)=10/(1+9e^{-t})');
xlabel('t'); ylabel('p(t)')

dt = [1,1/2,1/4,1/8,1/16];
% dt = 1/2^12;
fp = @(p)((1-p/10)*p);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Explicit Euler method
% figure(2)
subplot(2,2,2)
hold on
for j=1:length(dt)
    t = 0:dt(j):tend;
    pEx = 10./(1+9*exp(-t));
%     pbest = expEuler(fp,1,1/8,tend);
    fE = expEuler(fp,1,dt(j),tend);
%     errE(j) = sqrt((dt(j)/5)*sum((fE-pbest(1:2:end)).^2));
    errE(j) = sqrt((dt(j)/5)*sum((fE-pEx).^2));
    plot(t,fE,'Color','k');
    hold on
end
plot(t,pEx,'Color','r');
set(gcf,'Color','w');
title('Plot of the solution using the explicit Euler method');
xlabel('t'); ylabel('p(t)^{Euler}')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Heun method
% figure(3)
subplot(2,2,3)
hold on
for j=1:length(dt)
    t = 0:dt(j):tend;
    pEx = 10./(1+9*exp(-t));
%     pbest = Heun(fp,1,1/8,tend)
    fH = Heun(fp,1,dt(j),tend);
    errH(j) = sqrt((dt(j)/5)*sum((fH-pEx).^2));
%     errH(j) = sqrt((dt(j)/5)*sum((fH-pbest(1:2:end)).^2));
    plot(t,fH,'Color','k'); 
    hold on
end
plot(t,pEx,'Color','r');
set(gcf,'Color','w');
title('Plot of the solution using the Heun method')
xlabel('t'); ylabel('p(t)^{Heun}')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Runge-Kutta 4 method
% figure(4)
subplot(2,2,4)
hold on
for j=1:length(dt)
    t = 0:dt(j):tend;
    pEx = 10./(1+9*exp(-t));
%     pbest = RK4(fp,1,1/8,tend)
    fRK = RK4(fp,1,dt(j),tend);
    errRK(j) = sqrt((dt(j)/5)*sum((fRK-pEx).^2));
%     errRK(j) = sqrt((dt(j)/5)*sum((fRK-pbest(1:2:end)).^2));
    plot(t,fRK,'Color','k');
    hold on
end
plot(t,pEx,'Color','r');
set(gcf,'Color','w');
title('Plot of the solution using the Runge-Kutta 4 method');
xlabel('t'); ylabel('p(t)^{RK4}')
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
hold off