"""Named calculator function: trig tangent."""
import math

from calc.mathutil import guard_number


def trig_tangent(x):
    value = guard_number(x)
    return math.tan(value)
