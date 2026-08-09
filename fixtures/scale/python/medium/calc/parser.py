from calc.lexer import tokenize
from calc.tokens import NUMBER, OP, LPAREN, RPAREN
from calc.dispatch import precedence


def to_rpn(text):
    tokens = tokenize(text)
    output = []
    stack = []
    for kind, value in tokens:
        if kind == NUMBER:
            output.append((kind, value))
        elif kind == OP:
            while stack and stack[-1][0] == OP and precedence(stack[-1][1]) >= precedence(value):
                output.append(stack.pop())
            stack.append((kind, value))
        elif kind == LPAREN:
            stack.append((kind, value))
        elif kind == RPAREN:
            while stack and stack[-1][0] != LPAREN:
                output.append(stack.pop())
            stack.pop()
    while stack:
        output.append(stack.pop())
    return output
