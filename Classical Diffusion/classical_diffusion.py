import mu_phi
import initial_conc as iconc
from matplotlib import pyplot as plt
from numpy.fft import fft, ifft
# from numpy import meshgrid

def realpart(x):return [i.real for i in x];

def initial_conc(s:str, N, *v):
    match s:
        case 'unitstep':return iconc.get_c_unitstep(N, *v);
        case 'twostep':return iconc.get_c_twostep(N, *v);

def gibbsboltzmann_fft(N, n, alpha, s, *v):
    #N = 64;
    #n=200;
    c = initial_conc(s, N, *v);mu = mu_phi.get_mu_gibbsboltzmann(alpha, c);print(sum(c));plt.plot(range(N), c, label='Initial Profile');M = 1.0;delx = 0.01;alpha = 2.0;delt = 0.01;k = 1.0;
    for _ in range(n):mu = fft(mu_phi.get_mu_gibbsboltzmann(alpha, c));c = fft(c);c = realpart(ifft([i[0] + delt*M*k*k*i[1] for i in zip(c, mu)]));
    print(sum(c));plt.plot(range(N), c, label='Final Profile');plt.legend();

c = gibbsboltzmann_fft(64, 200, 1.0, 'unitstep', 0.5, 0.55, 0.65)
plt.show()
plt.close()
c = gibbsboltzmann_fft(64, 1000, 1.0, 'twostep', 0.25, 0.75, 0.45, 0.55, 0.45)
plt.show()
plt.close()

