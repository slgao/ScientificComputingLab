function ffg = INTRP(Ncg,Nfg,fcg)

%Check that the coars and fine dimensions match
if((mod(Nfg+1,Ncg+1)~=0)), error('Dimension mismatch'); end

N = (Nfg+1)/(Ncg+1);

%Include the boundary conditions on the coarse function fcg
fcgt = zeros(1,(Ncg+2)*(Ncg+2));        %Auxiliary vector
for j = 1:Ncg
    fcgt(j*(Ncg+2)+1+(1:Ncg)) = fcg((j-1)*Ncg+(1:Ncg));
end
fcg = fcgt;

%Interpolation (or The Index Nightmare)
k=0;
i=0;
while(i<(Ncg+1)*(Ncg+2))
    i=i+1;
    ffg(2*i-1+k*(Nfg+1)) = fcg(i);
    ffg(2*i+Nfg+1+k*(Nfg+1)) = (fcg(i)+fcg(i+Ncg+2))/2;
    ffg(2*i+k*(Nfg+1)) = (fcg(i)+fcg(i+1))/2;
    if(i < (Ncg+1)*(Ncg+2)-1)
        ffg(2*i+Nfg+2+k*(Nfg+1)) = (fcg(i)+fcg(i+1)+fcg(i+Ncg+2)+fcg(i+Ncg+3))/4;
    end
    if(mod(i,Ncg+2)==0), k = k+1; end
end

ffgt = zeros(1,Nfg^2);
for j = 1:Nfg
    ffgt((j-1)*Nfg + (1:Nfg)) = ffg(j*(Nfg+2)+1+(1:Nfg));
end
ffg = ffgt;