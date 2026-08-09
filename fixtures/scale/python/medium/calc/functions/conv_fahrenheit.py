"""Named calculator function: conv fahrenheit."""
import math

from calc.mathutil import guard_number


def conv_fahrenheit(x):
    value = guard_number(x)
    return value * 9.0 / 5.0 + 32.0
