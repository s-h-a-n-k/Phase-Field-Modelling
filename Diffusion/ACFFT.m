clear all;
clc;
clf;
kappa = 2.0;
L = 1.0;
A = 2.0;

N = 128;
DX = 1.0;

phi = zeros(N,1);

for i=(N/4)+1:3*N/4
phi(i) = 1.0;
endfor
plot(phi,'r;Initial Profile;');
hold on

halfN = N/2;
delk = 2*pi/N;
dt = 0.5;

for m = 1:400
g = 2*A.*phi.*(1.-phi).*(1.-2.*phi);
ghat = fft(g);
phihat = fft(phi);

for i=1:N
if((i-1) <= halfN) k = (i-1)*delk;
endif
if((i-1) > halfN) k = (i-1-N)*delk;
endif
k2 = k*k;
phihat(i) = (phihat(i) - L*dt*ghat(i))/(1+2*kappa*L*dt*k2);
endfor
phi = real(ifft(phihat));
endfor
plot(phi, 'g;Final Profile;');
