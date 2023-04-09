x=0.001:0.001:0.999;
y=x.*log(x).+(1.-x).*log(1.-x);
function y = f(t)
y=8.314*t;
endfunction
plot(x,f(300).*y);
hold on;
plot(x,f(600).*y);
xlabel("mole fraction");
ylabel("change in free energy (J/mol)");
title("delta G vs X");
legend("T = 300", "T = 600");
print -dpng free_energy_vs_mole_frac.png;
