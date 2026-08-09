def format_result(value):
    if value == int(value):
        return str(int(value))
    return "{:.4f}".format(value)


def format_line(expr, value):
    return expr + " = " + format_result(value)
