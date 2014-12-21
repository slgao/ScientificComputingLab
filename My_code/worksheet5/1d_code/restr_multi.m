function  r=restr_multi(N,res)
r=zeros(N,1);
for i=1:N
    r(i)=res(2*i);
end