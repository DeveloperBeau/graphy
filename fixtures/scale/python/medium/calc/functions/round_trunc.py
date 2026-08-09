"""Named calculator function: round trunc."""
import math

from calc.mathutil import guard_number


def round_trunc(x):
    value = guard_number(x)
    return math.trunc(value)
