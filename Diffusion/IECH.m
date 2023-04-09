clear all;
clc;
clf;
A = 2.0;
kappa = 1.0;
N = 32;
dx = 1.0;
m = 1;
c = zeros(N,1);
for i=(N/4)+1:3*N/4
c(i) = 1.0;
endfor
plot(c, 'r;Initial;');
hold on
halfN = N/2;
delk = 2*pi/N;
dt = 0.5;
for m=1:4000
g = 2*A.*c.*(1.-c).*(1.-2.*c);
ghat = fft(g);
chat = fft(c);
for i=1:N
if((i-1) <= halfN) k = (i-1)*delk;
endif
if((i-1) > halfN) k = (i-1-N)*delk;
endif
k2 = k*k;
k4 = k2*k2;
chat(i) = (chat(i)-dt*k2*ghat(i))/(1+2*kappa*k4*dt);
endfor
c = real(ifft(chat));
endfor
plot(c, ' g;final;')
chat = fft(c);
for i=1:N
if((i-1) <= halfN) k = (i-1)*delk;
endif
if((i-1) > halfN) k = (i-1-N)*delk;
endif
chat(i) = complex(0,1)*k*chat(i);
endfor
cprime = real(ifft(chat));
energy1 = 0.0;
energy2 = 0.0;
for i=1:N
energy1 = energy1+A*c(i)*c(i)*(1-c(i))*(1-c(i));
energy2 = energy2+kappa*cprime(i)*cprime(i);
endfor

%Two Interfaces
0.5*energy1
0.5*energy2
0.5*(energy1+energy2)

beta = sqrt(A/kappa);
x = 0:0.5:16;
hold on
plot(x,1./(1.+exp(-beta.*(x.-8.5))),'ro;exp;')
