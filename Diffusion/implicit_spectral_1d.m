%Clear the memory and figure
clear all
clf

%Define system size and parameters
N=128;
D=1.0;
delt=0.5;

%Make an initial sinusoidal profile
c=zeros(N,1);
M=2;

for j=1:N
c(j,1)=0.5*(1+sin(2*pi*M*j/N));
endfor

%Plot initial profile
plot(c, 'rs');
xlabel(' x');
ylabel(' c');
title('c vs x');
hold on

%For periodic BC implementation

%Define half length of box
halfN=N/2;

%Define the grid spacing in the Fourier space
delk=2*pi/N;

for k=1:20
for n=1:2000
ctilde=fft(c);
for i=1:N
if(i<halfN) k=i*delk;
endif
if(i>=halfN) k=(i-N)*delk;
endif
ctilde(i,1)=ctilde(i,1)/(1+D*k*k*delt);
endfor
endfor
c=real(ifft(ctilde));
plot(c);
endfor

l=['' ];
for i=1:18
l=[l ''];
endfor

legend('initial profile', ' 1', l.');
print (['implicit_spectral_m' num2str(M) '.png'], '-dpng');
