import math


def get_mu_gibbsboltzmann(alpha, c):return list(map(lambda i:alpha*(1 - 2 * i) + math.log(i / (1 - i)), c));
