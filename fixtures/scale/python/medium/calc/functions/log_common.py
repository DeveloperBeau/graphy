"""Named calculator function: log common."""
import math

from calc.mathutil import guard_positive


def log_common(x):
    value = guard_positive(x)
    return math.log10(value)
