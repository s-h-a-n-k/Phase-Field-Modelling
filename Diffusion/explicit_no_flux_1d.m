%Clean the figure and clear all data
clf
clear all

%Define parameters
delt=0.1;
delx=0.5;
D=1.0;
alpha=D*delt/(delx*delx);

%Set the initial profile
c=zeros(101,1);
c(1)=1.0;

%Plot the initial profile
plot(c, 'r-');
xlabel('x')
ylabel('c')
title('c vs x')

%Get handle
ax=gca;
set(ax,'linewidth',2.0);
axis('square');

%Hold the plot for future
hold on

%Evolve the composition and plot
for k=1:20
for j=1:500
for i=2:100
c(i)=c(i)*(1-2*alpha) + alpha*(c(i-1)+c(i+1));
endfor
c(101) = c(i)*(1-2*alpha) + 2*alpha*c(i-1);
endfor
plot(c)
endfor
l=[''];
for i=1:18
l=[l ''];
endfor
legend('Initial profile', '1', l.');
%Save figure
print ('explicit_no_flux.png', '-dpng');
