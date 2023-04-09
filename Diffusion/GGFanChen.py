from random import choice, seed
from matplotlib import pyplot as plt
import math
from numpy.fft import fft2, ifft2
from numpy import meshgrid

def realpart(x):
    xr = []
    for i in x:
        xr1 = []
        for j in i:
            xr1.append(j.real)
        xr.append(xr1)
    return xr
p = 6;
kappa1 = 1.0;
kappa2 = 1.2;
kappa3 = 1.4;
kappa4 = 1.5;
kappa5 = 1.6;
kappa6 = 1.8;
L1 = 1.0;
L2 = 1.0;
L3 = 1.0;
L4 = 1.0;
L5 = 1.0;
L6 = 1.0;
alpha = 1.0;
beta = 1.0;
gamma = 1.0;
N = 64;
dx = 1.0;
seed(123)
phi = [[choice([1,2,3,4,5,6]) for _ in range(N)] for _ in range(N)]
eta1 = [[0 for _ in range(N)] for _ in range(N)]
eta2 = [[0 for _ in range(N)] for _ in range(N)]
eta3 = [[0 for _ in range(N)] for _ in range(N)]
eta4 = [[0 for _ in range(N)] for _ in range(N)]
eta5 = [[0 for _ in range(N)] for _ in range(N)]
eta6 = [[0 for _ in range(N)] for _ in range(N)]
for i in range(N):
    for j in range(N):
        if phi[i][j] == 1:
            eta1[i][j] = 1.0;
        elif phi[i][j] == 2:
            eta2[i][j] = 1.0;
        elif phi[i][j] == 3:
            eta3[i][j] = 1.0;
        elif phi[i][j] == 4:
            eta4[i][j] = 1.0;
        elif phi[i][j] == 5:
            eta5[i][j] = 1.0;
        elif phi[i][j] == 6:
            eta6[i][j] = 1.0;
b = [[0 for _ in range(N)] for _ in range(N)]
for k in range(N):
    for l in range(N):
        b[k][l] = eta1[k][l]*(eta2[k][l]+eta3[k][l]+eta4[k][l]+eta5[k][l]+eta6[k][l]) + eta2[k][l]*(eta3[k][l]+eta4[k][l]+eta5[k][l]+eta6[k][l]) + eta3[k][l]*(eta4[k][l]+eta5[k][l]+eta6[k][l]) + eta4[k][l]*(eta5[k][l]+eta6[k][l]) + eta5[k][l]*eta6[k][l];
halfN = N/2;
delk = 2*math.pi/N;
dt = 0.5;
g1 = [[0 for _ in range(N)] for _ in range(N)]
g2 = [[0 for _ in range(N)] for _ in range(N)]
g3 = [[0 for _ in range(N)] for _ in range(N)]
g4 = [[0 for _ in range(N)] for _ in range(N)]
g5 = [[0 for _ in range(N)] for _ in range(N)]
g6 = [[0 for _ in range(N)] for _ in range(N)]
for n in range(10):
    for m in range(2):
        for j in range(N):
            for k in range(N):
                g1[j][k] = -eta1[j][k] + eta1[j][k]*eta1[j][k]*eta1[j][k] + 2*eta1[j][k]*(eta2[j][k]*eta2[j][k] + eta3[j][k]*eta3[j][k] + eta4[j][k]*eta4[j][k] + eta5[j][k]*eta5[j][k] + eta6[j][k]*eta6[j][k]);
                g2[j][k] = -eta2[j][k] + eta2[j][k]*eta2[j][k]*eta2[j][k] + 2*eta2[j][k]*(eta1[j][k]*eta1[j][k] + eta3[j][k]*eta3[j][k] + eta4[j][k]*eta4[j][k] + eta5[j][k]*eta5[j][k] + eta6[j][k]*eta6[j][k]);
                g3[j][k] = -eta3[j][k] + eta3[j][k]*eta3[j][k]*eta3[j][k] + 2*eta3[j][k]*(eta1[j][k]*eta1[j][k] + eta2[j][k]*eta2[j][k] + eta4[j][k]*eta4[j][k] + eta5[j][k]*eta5[j][k] + eta6[j][k]*eta6[j][k]);
                g4[j][k] = -eta4[j][k] + eta4[j][k]*eta4[j][k]*eta4[j][k] + 2*eta4[j][k]*(eta1[j][k]*eta1[j][k] + eta3[j][k]*eta3[j][k] + eta2[j][k]*eta2[j][k] + eta5[j][k]*eta5[j][k] + eta6[j][k]*eta6[j][k]);
                g5[j][k] = -eta5[j][k] + eta5[j][k]*eta5[j][k]*eta5[j][k] + 2*eta5[j][k]*(eta1[j][k]*eta1[j][k] + eta3[j][k]*eta3[j][k] + eta4[j][k]*eta4[j][k] + eta2[j][k]*eta2[j][k] + eta6[j][k]*eta6[j][k]);
                g6[j][k] = -eta6[j][k] + eta6[j][k]*eta6[j][k]*eta6[j][k] + 2*eta6[j][k]*(eta1[j][k]*eta1[j][k] + eta3[j][k]*eta3[j][k] + eta4[j][k]*eta4[j][k] + eta5[j][k]*eta5[j][k] + eta2[j][k]*eta2[j][k]);
        g1hat = fft2(g1);
        g2hat = fft2(g2);
        g3hat = fft2(g3);
        g4hat = fft2(g4);
        g5hat = fft2(g5);
        g6hat = fft2(g6);
        eta1hat = fft2(eta1);
        eta2hat = fft2(eta2);
        eta3hat = fft2(eta3);
        eta4hat = fft2(eta4);
        eta5hat = fft2(eta5);
        eta6hat = fft2(eta6);
        for i in range(N):
            for j in range(N):
                if (i-1) <= halfN:
                    kx = (i-1)*delk;
                if (i-1) > halfN:
                    kx = (i-1-N)*delk;
                if (j-1) <= halfN:
                    ky = (i-1)*delk;
                if (j-1) > halfN:
                    ky = (i-1-N)*delk;
                k2 = kx*kx+ky*ky;
                eta1hat[i][j] = (eta1hat[i][j]-L1*dt*g1hat[i][j])/(1+2*L1*kappa1*k2*dt);
                eta2hat[i][j] = (eta2hat[i][j]-L2*dt*g2hat[i][j])/(1+2*L2*kappa1*k2*dt);
                eta3hat[i][j] = (eta3hat[i][j]-L3*dt*g3hat[i][j])/(1+2*L3*kappa1*k2*dt);
                eta4hat[i][j] = (eta4hat[i][j]-L4*dt*g4hat[i][j])/(1+2*L4*kappa1*k2*dt);
                eta5hat[i][j] = (eta5hat[i][j]-L5*dt*g5hat[i][j])/(1+2*L5*kappa1*k2*dt);
                eta6hat[i][j] = (eta6hat[i][j]-L6*dt*g6hat[i][j])/(1+2*L6*kappa1*k2*dt);
        eta1 = realpart(ifft2(eta1hat));
        eta2 = realpart(ifft2(eta2hat));
        eta3 = realpart(ifft2(eta3hat));
        eta4 = realpart(ifft2(eta4hat));
        eta5 = realpart(ifft2(eta5hat));
        eta6 = realpart(ifft2(eta6hat));
        b = [[0 for _ in range(N)] for _ in range(N)]
        for k in range(N):
            for l in range(N):
                b[k][l] = eta1[k][l]*(eta2[k][l]+eta3[k][l]+eta4[k][l]+eta5[k][l]+eta6[k][l]) + eta2[k][l]*(eta3[k][l]+eta4[k][l]+eta5[k][l]+eta6[k][l]) + eta3[k][l]*(eta4[k][l]+eta5[k][l]+eta6[k][l]) + eta4[k][l]*(eta5[k][l]+eta6[k][l]) + eta5[k][l]*eta6[k][l];
#                 etal = [eta1[k][l], eta2[k][l], eta3[k][l], eta4[k][l], eta5[k][l], eta6[k][l]]
#                 eta = etal.index(max(etal))
#                 if eta == 0:
#                     eta1[k][l] = 1.0
#                     eta2[k][l] = 0.0
#                     eta3[k][l] = 0.0
#                     eta4[k][l] = 0.0
#                     eta5[k][l] = 0.0
#                     eta6[k][l] = 0.0
#                 elif eta == 1:
#                     eta1[k][l] = 0.0
#                     eta2[k][l] = 1.0
#                     eta3[k][l] = 0.0
#                     eta4[k][l] = 0.0
#                     eta5[k][l] = 0.0
#                     eta6[k][l] = 0.0
#                 elif eta == 2:
#                     eta1[k][l] = 0.0
#                     eta2[k][l] = 0.0
#                     eta3[k][l] = 1.0
#                     eta4[k][l] = 0.0
#                     eta5[k][l] = 0.0
#                     eta6[k][l] = 0.0
#                 elif eta == 3:
#                     eta1[k][l] = 0.0
#                     eta2[k][l] = 0.0
#                     eta3[k][l] = 0.0
#                     eta4[k][l] = 1.0
#                     eta5[k][l] = 0.0
#                     eta6[k][l] = 0.0
#                 elif eta == 4:
#                     eta1[k][l] = 0.0
#                     eta2[k][l] = 0.0
#                     eta3[k][l] = 0.0
#                     eta4[k][l] = 0.0
#                     eta5[k][l] = 1.0
#                     eta6[k][l] = 0.0
#                 elif eta == 5:
#                     eta1[k][l] = 0.0
#                     eta2[k][l] = 0.0
#                     eta3[k][l] = 0.0
#                     eta4[k][l] = 0.0
#                     eta5[k][l] = 0.0
#                     eta6[k][l] = 1.0
#                 else:
#                     exit()
    X, Y = meshgrid([i for i in range(1,N+1)], [i for i in range(1,N+1)])
    fig, ax = plt.subplots(1, 1)
    timer = fig.canvas.new_timer(interval = 2000)
    timer.add_callback(plt.close)
    cp = ax.contour(X, Y, eta1)
    fig.colorbar(cp)
    timer.start()
    plt.show()
