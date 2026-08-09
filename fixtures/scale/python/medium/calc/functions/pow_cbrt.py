"""Named calculator function: pow cbrt."""
import math

from calc.mathutil import guard_positive


def pow_cbrt(x):
    value = guard_positive(x)
    return value ** (1.0 / 3.0)
