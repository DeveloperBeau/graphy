"""Named calculator function: pow cube."""
import math

from calc.mathutil import guard_positive


def pow_cube(x):
    value = guard_positive(x)
    return value * value * value
