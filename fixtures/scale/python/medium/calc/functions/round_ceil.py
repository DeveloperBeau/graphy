"""Named calculator function: round ceil."""
import math

from calc.mathutil import guard_number


def round_ceil(x):
    value = guard_number(x)
    return math.ceil(value)
