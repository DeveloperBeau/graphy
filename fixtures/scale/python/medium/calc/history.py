from calc.formatting import format_line


class History:
    def __init__(self):
        self.entries = []

    def record(self, expr, value):
        self.entries.append(format_line(expr, value))

    def dump(self):
        return "\n".join(self.entries)
