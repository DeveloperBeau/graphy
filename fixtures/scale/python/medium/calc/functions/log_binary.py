"""Named calculator function: log binary."""
import math

from calc.mathutil import guard_positive


def log_binary(x):
    value = guard_positive(x)
    return math.log2(value)
