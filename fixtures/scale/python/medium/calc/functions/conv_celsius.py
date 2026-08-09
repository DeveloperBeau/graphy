"""Named calculator function: conv celsius."""
import math

from calc.mathutil import guard_number


def conv_celsius(x):
    value = guard_number(x)
    return (value - 32.0) * 5.0 / 9.0
