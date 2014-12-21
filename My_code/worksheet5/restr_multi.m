function  r=restr_multi(Nx,Ny,res)
j=1;
r=[];
while(j<=Ny)
    i=1;
    while(i<=Nx)
        r=[r,res(2*i+(2*j-1)*(2*Nx+1))];
        i=i+1;
    end
    j=j+1;
end