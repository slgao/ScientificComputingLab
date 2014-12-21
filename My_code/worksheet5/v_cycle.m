function Tf=v_cycle(T,FR,Nxf,Nyf)
Nxc=(Nxf-1)/2;Nyc=(Nyf-1)/2;
Dc=Nxc*Nyc;
Tf=GS_multi(Nxf,Nyf,FR,T);
rf=RES_multi(Nxf,Nyf,FR,Tf);

if (Nxf>3)
    rc=restr_multi(Nxc,Nyc,rf);
    ec1=zeros(1,Dc);
    ec2=v_cycle(ec1,rc,Nxc,Nyc);
    ef=interp_multi(Nxf,Nyf,ec2);
    Tf=Tf+ef;
end
Tf=GS_multi(Nxf,Nyf,FR,Tf);
