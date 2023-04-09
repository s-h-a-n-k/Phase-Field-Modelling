1;
function y = G(a,x)
y=a.*x.*(1.-x) .+ x.*log(x) .+ (1.-x).*log(1.-x);
endfunction
x=0.001:0.001:0.999;
a(1)=2.0;
for i=1:400
c(i)=fminbnd(@(x) G(a(i),x),0.001,0.499,optimset('TolX',1.e-12));
d(i)=fminbnd(@(x) G(a(i),x),0.501,0.999,optimset('TolX',1.e-12));
a(i+1)=a(i)+0.01;
endfor
for i=1:400
b(i)=a(i);
e(i)=c(401-i);
f(i)=a(401-i);
endfor
plot([e d],[1./f 1./b],'.-.r');
hold on;
%xlabel('mole fraction');
%ylabel('rescaled T');
%title('Phase Diagram');
%legend('deltaG_{min}');
%print ('phase_diagram.png', '-dpng');

