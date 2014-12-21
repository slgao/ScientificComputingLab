function fcg = RESTRICT(Ncg, Nfg, ffg)

%Check that the coarse and fine dimensions match
if((mod(Nfg+1,Ncg+1)~=0)), error('Dimension mismatch'); end

N = (Nfg+1)/(Ncg+1);

fcg = zeros(1,Ncg^2);
for k = 1:Ncg
    fcg((k-1)*Ncg+(1:Ncg)) = ffg(Nfg*(N*k-1)+N*(1:Ncg));
end