"""Named calculator function: bi hypotenuse."""
import math

from calc.mathutil import guard_number


def bi_hypotenuse(a, b):
    left = guard_number(a)
    right = guard_number(b)
    return math.sqrt(left * left + right * right)
