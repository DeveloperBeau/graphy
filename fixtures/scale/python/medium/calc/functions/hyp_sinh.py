"""Named calculator function: hyp sinh."""
import math

from calc.mathutil import guard_number


def hyp_sinh(x):
    value = guard_number(x)
    return (math.exp(value) - math.exp(-value)) / 2.0
