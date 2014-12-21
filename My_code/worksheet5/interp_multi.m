function e2=interp_multi(Nx,Ny,e)
a=(Nx-1)/2+2;b=(Ny-1)/2+2;
% insert the boundry conditions to the vector
econ=zeros(1,(a*b));
for i=2:b-1
    for j=2:a-1
        econ((i-1)*a+j)=e((i-2)*(a-2)+j-1);
    end
end
%%%%%%%%%%%%%%%%%%%%
% generate the Nx+1 row, Ny+1 column zeros matrix
% (in fact it is a vector ),and we will delete the extra row 
% and column later
e1=zeros(1,(Nx+1)*(Ny+1));
%%%%%%%%
% calculate the fine grid value and put them into the new zero vector
% ez(2i-1,2j-1)=1/4*(econ(i,j)+econ(i+1,j)+econ(i,j+1)+econ(i+1,j+1))
% ez(2i,2j-1)=1/2*(econ(i+1,j)+econ(i,j+1))
% ez(2i-1,2j)=1/2*(econ(i,j+1)+econ(i+1,j+1))
for i=1:b-1
    for j=1:a-1
        e1((2*i-2)*(Nx+1)+2*j-1)=1/4*(econ((i-1)*a+j)+econ(i*a+j)...
            +econ((i-1)*a+j+1)+econ(i*a+j+1));
        e1((2*i-1)*(Nx+1)+2*j-1)=1/2*(econ(i*a+j)+econ(i*a+j+1));
        e1((2*i-2)*(Nx+1)+2*j)=1/2*(econ((i-1)*a+j+1)+econ(i*a+j+1));
    end
end
%%%%%%%%%%%%%
% set a Nx by Ny matrix(in fact a vector) that is to say, deleting the extra
% elements in the last step
e2=zeros(1,Nx*Ny);
%%%%%%%%%%%%
for i=1:Ny
    for j=1:Nx
        e2((i-1)*Nx+j)=e1((i-1)*(Nx+1)+j);
    end
end
% insert the coarse grid entry into the finer grid
for i=1:b-2
    for j=1:a-2
        e2((2*i-1)*Nx+2*j)=e((i-1)*(a-2)+j);
    end
end
%%%%%%%%%%%%%