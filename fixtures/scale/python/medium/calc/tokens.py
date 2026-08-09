NUMBER = "NUMBER"
OP = "OP"
LPAREN = "LPAREN"
RPAREN = "RPAREN"


def make_token(kind, value):
    return (kind, value)


def is_operator(ch):
    return ch in "+-*/^"
