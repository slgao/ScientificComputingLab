function R = RES(Nx,Ny,T,RHS)

D = Nx*Ny;                              %Total dimension
hx = 1/(Nx+1);                          %Step for x
hy = 1/(Ny+1);                          %Step for y
c = (1/2)/(1/hx^2+1/hy^2);              %Tij multiplying constant
R = zeros(1,D);
for j = 1:D

    t1 = 0; t2 = 0; t3 = 0; t4 = 0;

    %Check the boundaries
    if(mod(j-1,Nx)~= 0), t1 = T(j-1)/hx^2; end
    if(mod(j,Nx)~=0), t2 = T(j+1)/hx^2; end
    if(j-Nx>0), t3 = T(j-Nx)/hy^2; end
    if(j+Nx<=D), t4 = T(j+Nx)/hy^2; end

    R(j) = RHS(j) - (t1 + t2 + t3 + t4 - (1/c)*T(j));             %Sum in the residual
    
end