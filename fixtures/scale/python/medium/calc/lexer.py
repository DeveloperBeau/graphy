from calc.tokens import make_token, is_operator, NUMBER, OP, LPAREN, RPAREN


def tokenize(text):
    tokens = []
    i = 0
    while i < len(text):
        ch = text[i]
        if ch.isspace():
            i += 1
        elif ch.isdigit():
            j = i
            while j < len(text) and (text[j].isdigit() or text[j] == "."):
                j += 1
            tokens.append(make_token(NUMBER, float(text[i:j])))
            i = j
        elif ch == "(":
            tokens.append(make_token(LPAREN, ch))
            i += 1
        elif ch == ")":
            tokens.append(make_token(RPAREN, ch))
            i += 1
        elif is_operator(ch):
            tokens.append(make_token(OP, ch))
            i += 1
        else:
            raise ValueError("bad char " + ch)
    return tokens
