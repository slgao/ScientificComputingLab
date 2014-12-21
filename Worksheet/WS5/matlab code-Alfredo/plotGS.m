%Plot the results of the different methods
function plotGS(Nx,Ny,M,t,i)

x = linspace(0,1,Nx+2);
y = linspace(0,1,Ny+2);
[X Y] = meshgrid(x,y);
TF = sin(pi*X).*sin(pi*Y);          %Exact solution
figure(ceil(100*rand(1)))
subplot(1,2,1)
surf(X,Y,TF); title('$T = \sin{(\pi x)}\sin{(\pi y)}$', 'Interpreter','latex');
axis([0 1 0 1 0 1]);

% hold on
% subplot(2,2,2)
% contour(y,x,TF); colorbar;
% set(gcf,'Color','w');
% set(gcf,'units','normalized','outerposition',[0 0 1 1],'Renderer','Zbuffer');

subplot(1,2,2)
surf(y,x,M); title(['Nx = ', num2str(Nx), ', Ny = ', num2str(Ny), ', ', num2str(i),...
     ' iterations, running time: ', num2str(t), ' s' ]); axis([0 1 0 1 0 1]);
% subplot(2,2,4)
% contour(y,x,M); colorbar;
set(gcf,'Color','w');
set(gcf,'units','normalized','outerposition',[0 0 1 1],'Renderer','Zbuffer');
colormap('cool')

% figure(5)
% surf(y,x,M); title(['Nx = ', num2str(Nx), ', Ny = ', num2str(Ny), ', ', num2str(i),...
%      ' iterations, running time: ', num2str(t), ' s' ]); axis([0 1 0 1 0 1]);
%  set(gcf,'Color','w','Renderer','Zbuffer'); shading interp; colormap('cool');