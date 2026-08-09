"""Named calculator function: num absolute."""
import math

from calc.mathutil import guard_number


def num_absolute(x):
    value = guard_number(x)
    return abs(value)
