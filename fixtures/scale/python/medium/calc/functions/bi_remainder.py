"""Named calculator function: bi remainder."""
import math

from calc.mathutil import guard_number


def bi_remainder(a, b):
    left = guard_number(a)
    right = guard_number(b)
    return math.fmod(left, right)
