"""Named calculator function: bi minimum."""
import math

from calc.mathutil import guard_number


def bi_minimum(a, b):
    left = guard_number(a)
    right = guard_number(b)
    return min(left, right)
