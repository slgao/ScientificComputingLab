function e2=interp_multi(N,e)
a=(N-1)/2+2;
% insert the boundry conditions to the vector
econ=zeros(1,a);

for j=2:a-1
        econ(j)=e(j-1);
end

e2=zeros(1,N);
for i=1:N
    if mod(i,2)~=0
        e2(i)=(econ((i+1)/2)+econ((i+1)/2+1))/2;
    else 
     e2(i)=econ(i/2+1);
    end
end


