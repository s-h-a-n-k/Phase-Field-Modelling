import math


def get_mu_gibbsboltzmann(alpha, c):return [alpha*(1 - 2 * i) + math.log(i / (1 - i)) for i in c]

