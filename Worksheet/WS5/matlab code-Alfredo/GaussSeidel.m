%GaussSeidel.m. Uses the Gauss-Seidel iterative scheme to solve the
%stationary heat equation in the interval ]0,1[ with Nx,Ny interior grid
%points, with T=0 on the boundary. Returns the final matrix M with the
%calculated temperature.

function [M e] = GaussSeidel(Nx,Ny,method)

D = Nx*Ny;                              %Total dimension
hx = 1/(Nx+1);                          %Step for x
hy = 1/(Ny+1);                          %Step for y
xn = hx:hx:1-hx;                        %x vector
yn = hy:hy:1-hy;                        %y vector
c = (1/2)/(1/hx^2+1/hy^2);              %Tij multiplying constant
T = ones(1,D);                          %Initial guess
R = Inf;                                %Residual of the system of equations
i = 0;                                  %Iterations required
store = Nx*Ny;                          %Number of floats stored
w = 2/(1+sin(pi*hx));                   %Overrelaxation factor
F = zeros(1,D);                         %Initialization of the RHS

%Do the iterations
tic 
while(R>1e-4)                                                    %Termination condition
    i = i+1;                                                     % # of iterations
    S1 = 0;                                                      %Sum in the Residual
    ind = [1 1];                                                 %Indices corresponding to j
    for j = 1:D
        
        t1 = 0; t2 = 0; t3 = 0; t4 = 0;
        
        %Check the boundaries
        if(mod(j-1,Nx)~= 0), t1 = T(j-1)/hx^2; end
        if(mod(j,Nx)~=0), t2 = T(j+1)/hx^2; end
        if(j-Nx>0), t3 = T(j-Nx)/hy^2; end
        if(j+Nx<=D), t4 = T(j+Nx)/hy^2; end
        
        F(j) = -2*pi^2*sin(pi*xn(ind(1))).*sin(pi*yn(ind(2)));      %Evaluate the function
        S1 = S1 + (F(j) - (t1 + t2 + t3 + t4 - (1/c)*T(j)))^2;      %Sum in the residual
        
        %Temperature vector using Gauss-Seidel
        if(method == 1), T(j) = c*(t1 + t2 + t3 + t4 - F(j));  end
        
        %Temperature vector using SOR Gauss-Seidel
        if(method == 2), T(j) = (1-w)*T(j) + w*c*(t1 + t2 + t3 + t4 - F(j));  end
        
        ind(1) = ind(1)+1;
        if(mod(j,Nx)==0), ind(1) = 1; ind(2) = ind(2) + 1; end
    end
    R(i) = sqrt(S1/D);                                           %Residual
end 
t = toc;

%Copy the approximate and exact vector solutions into matrix form
ind = [1,1];
S2 = 0;
F = F/(-2*pi^2);
TM = zeros(Nx,Ny);
TEx = zeros(Nx,Ny);
for j=1:D
    TM(ind(1),ind(2)) = T(j);
    TEx(ind(1),ind(2)) = F(j);
    S2 = S2 + (T(j)-F(j))^2;
    ind(1) = ind(1)+1;
    if(mod(j,Nx)==0), ind(1) = 1; ind(2) = ind(2) + 1; end
end

%Calculate the error
e = sqrt(S2/D);
% E = TM-TEx;
%Plot the error
% imagesc(xn,yn,E), shading interp, set(gcf,'Color','w'), colormap('cool');
% colorbar; title(['Error = T - E using ', num2str(i), ' iterations (Nx = Ny = 255)']);

%Create the final matrix M
M = zeros(Nx+2,Ny+2);
M(2:end-1,2:end-1) = TM;

%Plot the results
% plotGS(Nx,Ny,M,t,i);

%Display some information
disp(['Total running time: ', num2str(t), ' seconds',10, 'Final residual: ', num2str(R(end)),...
    10, 'Error: ', num2str(e), 10, 'Memory: ', num2str(store), 10, '# iterations: ', num2str(i)]);