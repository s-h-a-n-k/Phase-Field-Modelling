clear all;
clc;
clf;
N = 32;
dx = 1.0;
m = 3;
for i=1:N
c(i) = 0.5*(1+sin(2*pi*m*i*dx/N));
endfor
plot(c, 'r;Initial;');
hold on
halfN = N/2;
delk = 2*pi/N;
dt = 0.5;
for m=1:80
g = 2.*c.*(1.-c).*(1.-2.*c);
ghat = fft(g);
chat = fft(c);
for i=1:N
if((i-1) <= halfN) k = (i-1)*delk;
endif
if((i-1) > halfN) k = (i-1-N)*delk;
endif
k2 = k*k;
k4 = k2*k2;
chat(i) = (chat(i)-dt*k2*ghat(i))/(1+2*k4*dt);
endfor
c = real(ifft(chat));
endfor
plot(c, ' g;final;')

