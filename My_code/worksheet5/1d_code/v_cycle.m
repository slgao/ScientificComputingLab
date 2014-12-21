function Tf=v_cycle(T,FR,Nf)
Nc=(Nf-1)/2;
Tf=GS_multi(Nf,FR,T);
rf=RES_multi(Nf,FR,Tf);

if (Nf>15)
    rc=restr_multi(Nc,rf);
    ec1=zeros(1,Nc);
    ec2=v_cycle(ec1,rc,Nc);
    ef=interp_multi(Nf,ec2);
    Tf=Tf+ef;
end
Tf=GS_multi(Nf,FR,Tf);
