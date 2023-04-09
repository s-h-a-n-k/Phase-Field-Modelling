clf
clear all

delt=0.1;
delx=0.5;
D=1.0;
alpha=D*delt/(delx*delx);

c=zeros(101,1);
c(1)=1.0;
c(101)=0.0;

plot(c,'r-');

ax=gca;
set(ax,'linewidth',2.0);
axis('square');

xlabel(' x');
ylabel(' c');
title('c vs x');

hold on

for k=1:20
for j=1:500
for i=2:100
c(i)=c(i)*(1-2*alpha) + alpha*(c(i-1)+c(i+1));
endfor
endfor
plot(c);
endfor

l=[''];
for i=1:18
l=[l ''];
endfor

legend('Initial Profile', ' 1', l.');

print ('explicit_zeroc.png', '-dpng')
