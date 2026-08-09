from calc.parser import to_rpn
from calc.dispatch import apply_op
from calc.tokens import NUMBER, OP


def evaluate(text):
    rpn = to_rpn(text)
    stack = []
    for kind, value in rpn:
        if kind == NUMBER:
            stack.append(value)
        elif kind == OP:
            b = stack.pop()
            a = stack.pop()
            stack.append(apply_op(value, a, b))
    return stack.pop()
