clf
clear all

N=101;

delt=0.1;
delx=0.5;
D=1.0;
alpha=D*delt/(delx*delx);

c(1,1)=1.0;
for i=2:N
c(i,1)=0.0;
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
A(1,1)=1.0;
A(N,N)=1.0;

for i=2:N-1
A(i,i)=1.+ 2*alpha;
endfor

for i=2:N-1
A(i,i-1)=-alpha;
endfor

for i=3:N
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

print ('implicit_zeroc.png', '-dpng')
