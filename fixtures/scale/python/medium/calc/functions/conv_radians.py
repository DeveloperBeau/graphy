"""Named calculator function: conv radians."""
import math

from calc.mathutil import guard_number


def conv_radians(x):
    value = guard_number(x)
    return value * math.pi / 180.0
