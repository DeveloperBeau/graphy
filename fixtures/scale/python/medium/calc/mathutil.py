def guard_number(x):
    value = float(x)
    if value != value:
        raise ValueError("not a number")
    return value


def guard_positive(x):
    value = guard_number(x)
    if value <= 0:
        raise ValueError("must be positive")
    return value
