clf
clear all

N=101;

delt=0.1;
delx=0.5;
D=1.0;
alpha=D*delt/(delx*delx);

m=2;

for i=1:N
c(i,1)=0.5*(1+sin(2*pi*m*i/N));
endfor

plot(c,'r-');

ax=gca;
set(ax,'linewidth',2.0);
axis('square');

xlabel(' x');
ylabel(' c');
title('c vs x');

hold on

for i=1:N
cold(i,1)=c(i,1);
endfor

A=zeros(N,N);
A(N,1)=-alpha;
A(1,N)=-alpha;

for i=1:N
A(i,i)=1.+ 2*alpha;
endfor

for i=2:N
A(i,i-1)=-alpha;
endfor

for i=2:N
A(i-1,i)=-alpha;
endfor

A=inv(A);

for k=1:20
for j=1:500
c=A*cold;
for i=1:N
cold(i,1)=c(i,1);
endfor
endfor
plot(c);
endfor

l=['' ];
for i=1:18
l=[l ''];
endfor

legend('Initial Profile', ' 1', l.');

print (['implicit_pbc_m' num2str(m) '.png'], '-dpng')
