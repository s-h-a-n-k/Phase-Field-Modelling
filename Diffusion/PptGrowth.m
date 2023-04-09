clc;
clf;
more off

function y = f(x)
y = x*x*x*(10-15*x+6*x*x);
endfunction

function y = fp(x)
y = 3*x*x*(10-15*x+6*x*x) + x*x*x*(12*x-15);
endfunction

N = 64;
halfN = N/2;
R = 10;

for i=1:N
for j=1:N
if(((i-halfN)*(i-halfN) + (j-halfN)*(j-halfN)) < R*R)
c(i,j) = 1.0;
phi(i,j) = 1.0;
else
c(i,j) = 0.02;
phi(i,j) = 0.0;
endif
endfor
endfor

Cprofile = c(:,halfN);
Phiprofile = phi(:,halfN);
hold on
plot(Cprofile,'r;C Initial Profile;');
plot(Phiprofile,'b.-.;Phi Initial Profile;');

print -djpg InitialProfilePG.jpg

delk = 2*pi/N;
dt = 0.5;
A = 1;
B = 1;
P = 1;
M = 1;
kappac = 1;
kappaphi = 1;
for m=1:1
for n=1:100
for i=1:N
for j=1:N
W = f(phi(i,j));
if(phi(i,j) < 0) W = 0;
elseif (phi(i,j) > 1) W = 1;
endif
hc(i,j) = 2*A*c(i,j)*(1-W) - 2*B*(1-c(i,j))*W;
endfor
endfor
for i=1:N
for j=1:N
Wp = fp(phi(i,j));
if(phi(i,j) < 0) Wp = 0;
elseif(phi(i,j) > 1) Wp = 0;
endif
hphi(i,j) = -A*c(i,j)*c(i,j)*Wp + 2*B*(1-c(i,j))*(1-c(i,j))*Wp + 2*P*phi(i,j)*(1-phi(i,j))*(1-2*phi(i,j));
endfor
endfor
hchat = fft2(hc);
hphihat = fft2(hphi);
chat = fft2(c);
phihat = fft2(phi);
for i=1:N
for j=1:N
if((i-1) <= halfN) kx = (i-1)*delk;
endif
if((i-1) > halfN) kx = (i-1-N)*delk;
endif
if((j-1) <= halfN) ky = (j-1)*delk;
endif
if((j-1) > halfN) ky = (j-1-N)*delk;
endif
k2 = kx*kx+ky*ky;
k4 = k2*k2;
chat(i,j) = (chat(i,j)-dt*k2*hchat(i,j))/(1+2*k4*dt);
phihat(i,j) = (phihat(i,j) - dt*hphihat(i,j))/(1+2*k2*dt);
endfor
endfor
c = real(ifft2(chat));
phi = real(ifft2(phihat));
endfor
endfor
Cprofile = c(:,halfN);
Phiprofile = phi(:,halfN);
plot(Cprofile,'r.-.;C Final Profile;');
plot(Phiprofile,'b;Phi Final Profile;');
print -dpng FinalProfilePG.jpg
hold off
