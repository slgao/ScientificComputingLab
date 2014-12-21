function [Ti e] = vSolver(Nxf,Nyf)

Df = Nxf*Nyf;
hx = 1/(Nxf+1);                          %Step for x
hy = 1/(Nyf+1);                          %Step for y
xn = hx:hx:1-hx;                         %x vector
yn = hy:hy:1-hy;                         %y vector
store = 4*(Nxf*Nyf-1);                   %Number of floats stored
R = Inf;                                 %Initial residual
Ti = ones(1,Df);                         %Initial guess
global iter;                                   %Iteration counter
iter = 0;

%Calculate the RHS of the original PDE
ind = [1 1];                             %Indices corresponding to j
F = zeros(1,Df);
for j = 1:Df
    F(j) = -2*pi^2*sin(pi*xn(ind(1))).*sin(pi*yn(ind(2)));
    ind(1) = ind(1)+1;
    if(mod(j,Nxf)==0), ind(1) = 1; ind(2) = ind(2) + 1; end
end

%Solve the PDE running the vCycle routine until desired accuracy is reached
tic
while(R > 1e-4)
    Ti = vCycle(Ti,Nxf,F);      %Call vCycle routine
    R = RES(Nxf,Nyf,Ti,F);      %Calculate the residual
    R = sqrt(sum(R.^2)/Df);     %Calculate the residual norm
end
t = toc;

%Convert vector to matrix
ind = [1,1];
TM = zeros(Nxf,Nyf);
for j=1:Df
    TM(ind(1),ind(2)) = Ti(j);
    ind(1) = ind(1)+1;
    if(mod(j,Nxf)==0), ind(1) = 1; ind(2) = ind(2) + 1; end
end
S2 = sum((Ti-F/(-2*pi^2)).^2);
e = sqrt(S2/Df);

%Final matrix with boundary conditions
M = zeros(Nxf+2,Nyf+2);
M(2:end-1,2:end-1) = TM;

%Plot the results
% plotGS(Nxf,Nyf,M,t,iter);

%Display some information
disp(['Total running time: ', num2str(t), ' seconds',10, 'Final residual: ', num2str(R),...
    10, 'Error: ', num2str(e), 10, 'Memory: ', num2str(store), 10, '# iterations: ', num2str(iter)]);