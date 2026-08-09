"""Named calculator function: bi arctangent."""
import math

from calc.mathutil import guard_number


def bi_arctangent(a, b):
    left = guard_number(a)
    right = guard_number(b)
    return math.atan2(left, right)
