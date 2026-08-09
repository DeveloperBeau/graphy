"""Named calculator function: round nearest."""
import math

from calc.mathutil import guard_number


def round_nearest(x):
    value = guard_number(x)
    return math.floor(value + 0.5)
