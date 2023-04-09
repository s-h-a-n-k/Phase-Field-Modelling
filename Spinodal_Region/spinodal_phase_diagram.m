1;
function z = Gpp(a,x)
z=-2*a .+ 1./x .+ 1./(1.-x);
endfunction
a(1)=2.01;
x0=[0.0001;0.5001];
x1=[0.4999;0.9999];
for i=1:400
f(i)=fzero(@(x) Gpp(a(i),x),x0,optimset('TolX',1.e-12));
g(i)=fzero(@(x) Gpp(a(i),x),x1,optimset('TolX',1.e-12));
a(i+1)=a(i)+0.01;
endfor
for i=1:400
b(i)=a(i);
h(i)=f(401-i);
j(i)=a(401-i);
endfor
plot([h g],[1./j 1./b], '.-.g');
hold on;
source /home/shantanu/phase_field_modelling/Phase_Diagram/phase_diagram.use.m;
xlabel('mole fraction');
ylabel('rescaled T');
title('Phase Diagram');
legend('spinodal line', 'deltaG_{min}');
print ('phase_diagram_spinodal.png', '-dpng');


