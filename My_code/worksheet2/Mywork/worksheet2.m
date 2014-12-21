clear all;
dt=.01;
tend=5;
t=0:dt:tend;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Exact solution
PEx=200./(20-10*exp(-7*t));
% subplot(2,2,1)
plot(t,PEx,'r');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Explicit Euler Method
dt=[1,1/2,1/4,1/8];
tend=5;
fp=@(p)(7*(1-p/10)*p);
% subplot(2,2,2)
PE=@(t)(200./(20-10*exp(-7*t)));
for j=1:length(dt)
    t=0:dt(j):5;
    fE=expEuler(fp,20,dt(j),tend);
    PEx=PE(t);
    E(j)=sqrt(dt(j)/5*sum((fE-PEx).^2));
    plot(t,fE,'b');
    hold on;
end
plot(t,PEx,'r');
set(gcf,'color','w');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Method of Heun
dt=[1,1/2,1/4,1/8];
tend=5;
fp=@(p)(7*(1-p/10)*p);
% subplot(2,2,3)
PE=@(t)(200./(20-10*exp(-7*t)));
for j=1:length(dt)
    t=0:dt(j):5;
    fH=Heun(fp,20,dt(j),tend);
    PEx=PE(t);
    E(j)=sqrt(dt(j)/5*sum((fH-PEx).^2));
    plot(t,fH,'b');
    hold on;
end
plot(t,PEx,'r');
set(gcf,'color','w');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% implicit Euler method
dt=[1/2,1/4,1/8,1/16,1/32];
tend=5;
fp=@(p)(7*(1-p/10)*p);
% subplot(2,2,4)
PE=@(t)(200./(20-10*exp(-7*t)));
for j=1:length(dt)
    t=0:dt(j):5;
    fI=imEuler(fp,20,dt(j),tend);
    PEx=PE(t);
    E(j)=sqrt(dt(j)/5*sum((fI-PEx).^2));
    plot(t,fI,'b');
    hold on;
end
plot(t,PEx,'r');
set(gcf,'color','w');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% second order Adams-Moulton method
dt=[1/4,1/8,1/16,1/32];
tend=5;
fp=@(p)(7*(1-p/10)*p);
% subplot(2,2,2)
PE=@(t)(200./(20-10*exp(-7*t)));
for j=1:length(dt)
    t=0:dt(j):5;
    fA=Adams(fp,20,dt(j),tend);
    PEx=PE(t);
    E(j)=sqrt(dt(j)/5*sum((fA-PEx).^2));
    plot(t,fA,'b');
    hold on;
end
plot(t,PEx,'r');
set(gcf,'color','w');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Linearisation 1
dt=[1/2,1/4,1/8,1/16,1/32];
tend=5;
fp=@(p)(7*(1-p/10)*p);
% subplot(2,2,2)
PE=@(t)(200./(20-10*exp(-7*t)));
for j=1:length(dt)
    t=0:dt(j):5;
    fL1=Linear1(20,dt(j),tend);
    PEx=PE(t);
    E(j)=sqrt(dt(j)/5*sum((fL1-PEx).^2));
    plot(t,fL1,'b');
    hold on;
end
plot(t,PEx,'r');
set(gcf,'color','w');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Linearisation 2
dt=[1/2,1/4,1/8,1/16,1/32,1/64,1/128,1/256,1/512];
tend=5;
fp=@(p)(7*(1-p/10)*p);
% subplot(2,2,2)
PE=@(t)(200./(20-10*exp(-7*t)));
for j=1:length(dt)
    t=0:dt(j):5;
    fL2=Linear2(20,dt(j),tend);
    PEx=PE(t);
    E(j)=sqrt(dt(j)/5*sum((fL2-PEx).^2));
    plot(t,fL2,'b');
    hold on;
end
plot(t,PEx,'r');
set(gcf,'color','w');
