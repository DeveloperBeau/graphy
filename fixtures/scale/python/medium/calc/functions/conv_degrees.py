"""Named calculator function: conv degrees."""
import math

from calc.mathutil import guard_number


def conv_degrees(x):
    value = guard_number(x)
    return value * 180.0 / math.pi
