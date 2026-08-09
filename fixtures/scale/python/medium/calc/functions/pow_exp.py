"""Named calculator function: pow exp."""
import math

from calc.mathutil import guard_positive


def pow_exp(x):
    value = guard_positive(x)
    return math.exp(value)
