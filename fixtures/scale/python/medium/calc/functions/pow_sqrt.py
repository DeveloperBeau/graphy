"""Named calculator function: pow sqrt."""
import math

from calc.mathutil import guard_positive


def pow_sqrt(x):
    value = guard_positive(x)
    return math.sqrt(value)
