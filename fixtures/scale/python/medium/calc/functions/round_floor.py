"""Named calculator function: round floor."""
import math

from calc.mathutil import guard_number


def round_floor(x):
    value = guard_number(x)
    return math.floor(value)
