from calc.arithmetic import add, subtract, multiply, divide, power


def apply_op(op, a, b):
    table = {
        "+": add,
        "-": subtract,
        "*": multiply,
        "/": divide,
        "^": power,
    }
    return table[op](a, b)


def precedence(op):
    return {"+": 1, "-": 1, "*": 2, "/": 2, "^": 3}[op]
