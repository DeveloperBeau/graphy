"""Named calculator function: hyp tanh."""
import math

from calc.mathutil import guard_number


def hyp_tanh(x):
    value = guard_number(x)
    return (math.exp(2 * value) - 1) / (math.exp(2 * value) + 1)
