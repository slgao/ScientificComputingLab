function T = GS(Nx,Ny,Ti,RHS,method)

D = Nx*Ny;                              %Total dimension
hx = 1/(Nx+1);                          %Step for x
hy = 1/(Ny+1);                          %Step for y
c = (1/2)/(1/hx^2+1/hy^2);              %Tij multiplying constant
w = 2/(1+sin(pi*hx));                   %Overrelaxation factor
T = Ti;
global iter;

%Do the iterations
for k = 1:2                                                      % Do 2 GS iterations
    iter = iter+1;
    for j = 1:D
        
        t1 = 0; t2 = 0; t3 = 0; t4 = 0;
        
        %Check the boundaries
        if(mod(j-1,Nx)~= 0), t1 = T(j-1)/hx^2; end
        if(mod(j,Nx)~=0), t2 = T(j+1)/hx^2; end
        if(j-Nx>0), t3 = T(j-Nx)/hy^2; end
        if(j+Nx<=D), t4 = T(j+Nx)/hy^2; end
        
        %Temperature vector using Gauss-Seidel
        if(method == 1), T(j) = c*(t1 + t2 + t3 + t4 - RHS(j));  end
        
        %Temperature vector using SOR Gauss-Seidel
        if(method == 2), T(j) = (1-w)*T(j) + w*c*(t1 + t2 + t3 + t4 - RHS(j));  end
        
    end
end 