"""Named calculator function: trig cosine."""
import math

from calc.mathutil import guard_number


def trig_cosine(x):
    value = guard_number(x)
    return math.cos(value)
