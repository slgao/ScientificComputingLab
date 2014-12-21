function Tf = vCycle(Ti,Nxf,RHS)

Nyf = Nxf;

Nxc = (Nxf+1)/2-1;
Nyc = Nxc;
Dc = Nxc*Nyc;

Tf = GS(Nxf,Nyf,Ti,RHS,1);

Rf = RES(Nxf,Nyf,Tf,RHS);
if(Nxf > 3)    
    Rc = RESTRICT(Nxc,Nxf,Rf);
    Eic = zeros(1,Dc);
    Efc = vCycle(Eic,Nxc,Rc);
    Eff = INTRP(Nxc,Nxf,Efc);
    Tf = Tf + Eff;
end

Tf = GS(Nxf,Nyf,Tf,RHS,1);