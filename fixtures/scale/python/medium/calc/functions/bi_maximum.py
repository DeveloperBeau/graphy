"""Named calculator function: bi maximum."""
import math

from calc.mathutil import guard_number


def bi_maximum(a, b):
    left = guard_number(a)
    right = guard_number(b)
    return max(left, right)
