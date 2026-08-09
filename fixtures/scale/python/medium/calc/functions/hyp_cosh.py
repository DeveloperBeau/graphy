"""Named calculator function: hyp cosh."""
import math

from calc.mathutil import guard_number


def hyp_cosh(x):
    value = guard_number(x)
    return (math.exp(value) + math.exp(-value)) / 2.0
