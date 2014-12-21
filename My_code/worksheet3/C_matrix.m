function  M=C_matrix(Nx,Ny)
hx=1/(Nx+1);
hy=1/(Ny+1);
D=Nx*Ny;
M=zeros(D,D);
for i=1:Nx*Ny
    M(i,i)=-2*(hx^2+hy^2);
    if mod(i,Nx)~=0
        M(i,i+1)=hy^2;
    end
    if mod(i-1,Nx)~=0
        M(i,i-1)=hy^2;
    end
    if i+Nx<=Nx*Ny
        M(i,i+Nx)=hx^2;
    end
    if i-Nx>0
        M(i,i-Nx)=hx^2;
    end
end