"""Named calculator function: trig sine."""
import math

from calc.mathutil import guard_number


def trig_sine(x):
    value = guard_number(x)
    return math.sin(value)
