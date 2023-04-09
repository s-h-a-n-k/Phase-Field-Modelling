# import math

def get_c_unitstep(N, n, c1, c2):
# c1=0.45;
# c2=0.55;
    c=list();n=N*n;
    for i in range(N):
        if(i<=n):c.append(c1);
        else:c.append(c2);
    return c

def get_c_twostep(N, n1, n2, c1, c2, c3):
    c=list();n1=N*n1;n2=N*n2;
    for i in range(N):
        if(i<=n1):c.append(c1);
        elif(i<=n2):c.append(c2);
        else:c.append(c3);
    return c
