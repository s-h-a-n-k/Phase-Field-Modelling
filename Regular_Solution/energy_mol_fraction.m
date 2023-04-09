x=0.001:0.001:0.999;
DS=x.*log(x).+(1.-x).*log(1.-x);
alpha=4.5;
function y = f(t)
y=8.314*t;
endfunction
DH=alpha.*x.*(1.-x);
plot(x,DH,x,DS,x,DH+DS);
xlabel('mole fraction');
title(['Energy vs Mole fraction, ' num2str(alpha)]);
legend('DH', 'DS', 'DG');
print (['energy_vs_mole_fraction_alpha' num2str(alpha) '.png'], '-dpng');
plot(x,(DH+DS).*f(300))
xlabel('mole fraction')
ylabel('free energy change (J/mol)')
title(['delta G vs X, ' num2str(alpha)])
print (['free_energy_vs_mole_fraction_alpha' num2str(alpha) '_t300.png'], '-dpng')
