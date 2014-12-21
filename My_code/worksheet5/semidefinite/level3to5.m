clear all;

level=3;
if level<3
    disp('level is too low!');
    return;
end
for i=1:level
    N(i)=2^(i)-1;
end

% if level>5
% R65=zeros(N(5),N(6));
% end
if level>4
R54=zeros(N(4),N(5));
end
if level>3
R43=zeros(N(3),N(4));
end
R32=zeros(N(2),N(3));
R21=zeros(N(1),N(2));
h=1/(N(level)+1);
L=(diag(ones(N(level)-1,1),1)+diag(-2*ones(N(level),1))+diag(ones(N(level)-1,1),-1))/h^2;
x=h:h:1-h;
F=zeros(1,N(level));
for i=1:N(level)
F(i)=-2*pi^2*sin(pi*x(i));
end
F=F';


% if level>5
% for m=1:N(5)
%     
%   R65(m,1+2*(m-1))=1/4;
%   R65(m,2+2*(m-1))=1/2;
%   R65(m,3+2*(m-1))=1/4;
%    
% end
% end
if level>4
for m=1:N(4)
    
  R54(m,1+2*(m-1))=1/4;
  R54(m,2+2*(m-1))=1/2;
  R54(m,3+2*(m-1))=1/4;
   
end
end
if level>3
for m=1:N(3)
    
  R43(m,1+2*(m-1))=1/4;
  R43(m,2+2*(m-1))=1/2;
  R43(m,3+2*(m-1))=1/4;
   
end
end

for m=1:N(2)
    
  R32(m,1+2*(m-1))=1/4;
  R32(m,2+2*(m-1))=1/2;
  R32(m,3+2*(m-1))=1/4;
   
end

for m=1:N(1)
    
  R21(m,1+2*(m-1))=1/4;
  R21(m,2+2*(m-1))=1/2;
  R21(m,3+2*(m-1))=1/4;
   
end
% if level>6
% P67=2*R76';
% end
% if level>5
% P56=2*R65';
% end
if level>4
P45=2*R54';
end
if level>3
P34=2*R43';
end
P23=2*R32';
P12=2*R21';
% for adding more levels,we have to change below
% I7=eye(N(7));
% if level==6
% I6=eye(N(6));I56=eye(N(5)+N(6));I456=eye(N(4)+N(5)+N(6));I3456=eye(N(3)+N(4)+N(5)+N(6));
%  SE=cat(2,P56*P45*P34*P23*P12,P56*P45*P34*P23,cat(2,P56*P45*P34,cat(2,P56*P45,cat(2,P56,I6)*I56)*I456)*I3456);
% end
if level==5
I5=eye(N(5));I45=eye(N(4)+N(5)); I345=eye(N(3)+N(4)+N(5));
SE=cat(2,P45*P34*P23*P12,P45*P34*P23,cat(2,P45*P34,cat(2,P45,I5)*I45)*I345);
end
if level==4
I4=eye(N(4));I34=eye(N(3)+N(4));
SE=cat(2,P34*P23*P12,P34*P23,cat(2,P34,I4)*I34);
end
if level==3
I3=eye(N(3));
SE=cat(2,P23*P12,P23,I3);
end

LE=SE'*L*SE;
FE=SE'*F;
% if level>5
%     LE16=LE(1,58:120);LE61=LE16';
%     LE26=LE(2:4,58:120);LE62=LE26';
%     LE36=LE(5:11,58:120);LE63=LE36';
%     LE46=LE(12:26,58:120);LE64=LE46';
%     LE56=LE(27:57,58:120);LE65=LE56';
%     LE66=LE(58:120,58:120);

% end
if level>4
    LE15=LE(1,27:57);LE51=LE15';
    LE25=LE(2:4,27:57);LE52=LE25';
    LE35=LE(5:11,27:57);LE53=LE35';
    LE45=LE(12:26,27:57);LE54=LE45';
    LE55=LE(27:57,27:57);
end
if level>3
    LE14=LE(1,12:26);LE41=LE14';
    LE24=LE(2:4,12:26);LE42=LE24';
    LE34=LE(5:11,12:26);LE43=LE34';
    LE44=LE(12:26,12:26);
end
LE11=LE(1,1);
LE12=LE(1,2:4);LE21=LE12';
LE13=LE(1,5:11);LE31=LE13';

LE22=LE(2:4,2:4);
LE23=LE(2:4,5:11);LE32=LE23';

LE33=LE(5:11,5:11);





FE1=FE(1);
FE2=FE(2:4,:);
FE3=FE(5:11,:);
% if level>5
% FE6=FE(58:120,:);
% end
if level>4
FE5=FE(27:57,:);
end
if level>3
FE4=FE(12:26,:);
end



% if level>5
% w6=ones(N(6),1);
% end
if level>4
w5=ones(N(5),1);
end
if level>3
w4=ones(N(4),1);
end
w1=ones(1,1);
w2=ones(N(2),1);
w3=ones(N(3),1);


res=1;
tic;
iter=0;
num_while=0;
num_gs=0;
while(res>1e-8)
%     if level>5
% for i=1:N(6)
%     sum1=0;sum2=0;
%     if i>1
%     for j=1:i-1
%         sum1=sum1+LE66(i,j)*w6(j);
%     end
%     end
%     if i<N(6)
%     for j=i+1:N(6)
%         sum2=sum2+LE66(i,j)*w6(j);
%     end
%     end
%     r6=FE6(i)-LE61*w1-LE62*w2-LE63*w3-LE64*w4--LE65*w5;
%     w6(i)=(r6(i)-sum1-sum2)/LE66(i,i);
%     iter=iter+1;
% end
%     end
    if level>4
for i=1:N(5)
    sum1=0;sum2=0;
    if i>1
    for j=1:i-1
        sum1=sum1+LE55(i,j)*w5(j);
    end
    end
    if i<N(5)
    for j=i+1:N(5)
        sum2=sum2+LE55(i,j)*w5(j);
    end
    end
%     if level==6
%         r5=FE5(i)-LE51*w1-LE52*w2-LE53*w3-LE54*w4-LE56*w6;
%     end
%     if level==5
        r5=FE5(i)-LE51*w1-LE52*w2-LE53*w3-LE54*w4;
%     end
    w5(i)=(r5(i)-sum1-sum2)/LE55(i,i);
    iter=iter+1;
end
num_gs=num_gs+1;
    end
    if level>3
for i=1:N(4)
    sum1=0;sum2=0;
    if i>1
    for j=1:i-1
        sum1=sum1+LE44(i,j)*w4(j);
    end
    end
    if i<N(4)
    for j=i+1:N(4)
        sum2=sum2+LE44(i,j)*w4(j);
    end
    end
%     if level==6
%     r4=FE4(i)-LE41*w1-LE42*w2-LE43*w3-LE45*w5-LE46*w6;
%     end
    if level==5
    r4=FE4(i)-LE41*w1-LE42*w2-LE43*w3-LE45*w5;
    end
    if level==4
    r4=FE4(i)-LE41*w1-LE42*w2-LE43*w3;
    end
    w4(i)=(r4(i)-sum1-sum2)/LE44(i,i);
    iter=iter+1;
end
num_gs=num_gs+1;
    end
    
for i=1:N(3)
    sum1=0;sum2=0;
    if i>1
    for j=1:i-1
        sum1=sum1+LE33(i,j)*w3(j);
    end
    end
    if i<N(3)
    for j=i+1:N(3)
        sum2=sum2+LE33(i,j)*w3(j);
    end
    end
%     if level==6
%     r3=FE3(i)-LE31*w1-LE32*w2-LE34*w4-LE35*w5-LE36*w6;
%     end
    if level==5
    r3=FE3(i)-LE31*w1-LE32*w2-LE34*w4-LE35*w5;
    end
    if level==4
    r3=FE3(i)-LE31*w1-LE32*w2-LE34*w4;
    end
    if level==3
    r3=FE3(i)-LE31*w1-LE32*w2;
    end
    w3(i)=(r3(i)-sum1-sum2)/LE33(i,i);
    iter=iter+1;
end
num_gs=num_gs+1;
for i=1:N(2)
    sum1=0;sum2=0;
    if i>1
    for j=1:i-1
        sum1=sum1+LE22(i,j)*w2(j);
    end
    end
    if i<N(2)
    for j=i+1:N(2)
        sum2=sum2+LE22(i,j)*w2(j);
    end
    end
%     if level==6
%     r2=FE2(i)-LE21*w1-LE23*w3-LE24*w4-LE25*w5-LE26*w6;
%     end
    if level==5
    r2=FE2(i)-LE21*w1-LE23*w3-LE24*w4-LE25*w5;
    end
    if level==4
    r2=FE2(i)-LE21*w1-LE23*w3-LE24*w4;
    end
    if level==3
    r2=FE2(i)-LE21*w1-LE23*w3;
    end
    w2(i)=(r2(i)-sum1-sum2)/LE22(i,i);
    iter=iter+1;
end
num_gs=num_gs+1;
for i=1:N(1)
    sum1=0;sum2=0;
    if i>1
    for j=1:i-1
        sum1=sum1+LE11(i,j)*w1(j);
    end
    end
    if i<N(1)
    for j=i+1:N(1)
        sum2=sum2+LE11(i,j)*w1(j);
    end
    end
%     if level==6
%     r1=FE1(i)-LE12*w2-LE13*w3-LE14*w4-LE15*w5-LE16*w6;
%     end
    if level==5
    r1=FE1(i)-LE12*w2-LE13*w3-LE14*w4-LE15*w5;
    end
    if level==4
    r1=FE1(i)-LE12*w2-LE13*w3-LE14*w4;
    end
    if level==3
    r1=FE1(i)-LE12*w2-LE13*w3;
    end
    w1(i)=(r1(i)-sum1-sum2)/LE11(i,i);
    iter=iter+1;
end
num_gs=num_gs+1;
% if level==6
%     w=cat(1,w1,w2,w3,w4,w5,w6);
% end
if level==5
    w=cat(1,w1,w2,w3,w4,w5);
end
if level==4
    w=cat(1,w1,w2,w3,w4);
end
if level==3
    w=cat(1,w1,w2,w3);
end
u=SE*w;
res=F-L*u;
res=norm(res);
num_while=num_while+1;
end
t=toc
num_while
num_gs
iter
plot(x,u);






