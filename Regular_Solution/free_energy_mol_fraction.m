1;
function y = G(x,a)
y=a.*x.*(1.-x) .+ x.*log(x) .+ (1.-x).*log(1.-x);
endfunction
hold on;
x=0.001:0.001:0.999;
a=1.0;
A=[a ];
for i=1:4
a=a+1;
A=[A a];
plot(x,G(x,a));
endfor
xlabel('mole fraction');
ylabel('unitless free energy');
title('delta G / RT vs X');
legend(num2str(A.'));
print ('free_energy_alpha.png', '-dpng')

