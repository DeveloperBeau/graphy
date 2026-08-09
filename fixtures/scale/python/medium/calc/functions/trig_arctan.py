"""Named calculator function: trig arctan."""
import math

from calc.mathutil import guard_number


def trig_arctan(x):
    value = guard_number(x)
    return math.atan(value)
