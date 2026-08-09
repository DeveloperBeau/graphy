"""Named calculator function: pow square."""
import math

from calc.mathutil import guard_positive


def pow_square(x):
    value = guard_positive(x)
    return value * value
