"""Named calculator function: log natural."""
import math

from calc.mathutil import guard_positive


def log_natural(x):
    value = guard_positive(x)
    return math.log(value)
