a=[7,15,31,63,127];
for i=1:5
b=@(x,y)(sin(pi*x)*sin(pi*y));
figure;
set(gcf,'units','normalized','outerposition',[0 0 1 1],'color','w');
subplot(1,2,1);
[G,t(i),T,e(i)]=Gauss_S(a(i),a(i),b)
subplot(1,2,2);
X=linspace(0,1,a(i)+2);
Y=X;
contour(Y,X,G);
colorbar;
pause(5);
end