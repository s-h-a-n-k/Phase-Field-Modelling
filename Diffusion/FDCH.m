dt = 0.001;
dx = 1.0;
D = 1.0;
kappa = 1.0;
beta1 = dt/(dx*dx);
beta2 = 2*kappa*dt/(dx*dx*dx*dx);
n = 32;
N = 40000;
clf
hold on
m = 3;
for i=1:n
oldc(i) = 0.5*(1+sin(2*pi*m*i*dx/n));
newc(i) = 0.0;
endfor
plot(oldc, ' g');
A = 1.0;
g = (2*A).*oldc.*(1.-oldc).*(1.-2.*oldc);
for j = 1:N
for i = 1:n
w = i-1;
ww = i-2;
e = i+1;
ee = i+2;
if(ww<1) ww = ww+n;
endif
if(ee>n) ee = ee-n;
endif
if(w<1) w = w+n;
endif
if(e>n) e = e-n;
endif
newc(i) = oldc(i) + beta1*(g(w)-2*g(i)+g(e)) - beta2*(oldc(ww)-4*oldc(w)+6*oldc(i)-4*oldc(e)+oldc(ee));
endfor
for i=1:n
oldc(i) = newc(i);
endfor
endfor
plot(oldc, ' r')
