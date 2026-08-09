"""Named calculator function: num sign."""
import math

from calc.mathutil import guard_number


def num_sign(x):
    value = guard_number(x)
    return (value > 0) - (value < 0)
