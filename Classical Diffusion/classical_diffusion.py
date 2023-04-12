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


class gibbsboltzmann:
    def fft(N, n, alpha, beta, s, *v):
        # alpha = omega / RT
        # beta = delt * M * k**2
        c = initial_conc(s, N, *v);mu = mu_phi.get_mu_gibbsboltzmann(alpha, c);print(sum(c));plt.plot(range(N), c, label='Initial Profile');
        for _ in range(n):mu = fft(mu_phi.get_mu_gibbsboltzmann(alpha, c));c = fft(c);c = realpart(ifft([i[0] + beta*i[1] for i in zip(c, mu)]));
        print(sum(c));plt.plot(range(N), c, label='Final Profile');plt.legend();


    def fdm(N, n, alpha, beta, s, *v):
        # alpha = omega / RT
        # beta = M * delt / delx**2
        c = initial_conc(s, N, *v);mu = mu_phi.get_mu_gibbsboltzmann(alpha, c);print(sum(c));plt.plot(range(N), c, label='Initial Profile');mu.insert(0, mu[-1]);mu.append(mu[1]);
        for _ in range(n):c = [c[i-1] + beta*(mu[i+1]+mu[i-1]-2*mu[i]) for i in range(1,N+1)];mu = mu_phi.get_mu_gibbsboltzmann(alpha, c);mu.insert(0, mu[-1]);mu.append(mu[1]);
        print(sum(c));plt.plot(range(N), c, label='Final Profile');plt.legend();


c = gibbsboltzmann.fft(64, 200, 2.0, 0.01, 'unitstep', 0.5, 0.55, 0.65)
plt.show()
plt.close()
c = gibbsboltzmann.fft(64, 3600, 2.0, 0.01, 'twostep', 0.25, 0.75, 0.45, 0.55, 0.45)
plt.show()
plt.close()
c = gibbsboltzmann.fdm(64, 50,  1.0, 0.1, 'unitstep', 0.5, 0.55, 0.65)
plt.show()
plt.close()
c = gibbsboltzmann.fdm(64, 1000, 1.0, 0.1, 'twostep', 0.25, 0.75, 0.45, 0.55, 0.45)
plt.show()
plt.close()

