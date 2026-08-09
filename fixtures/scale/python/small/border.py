from theme import theme_chars


def border_top(width, theme):
    chars = theme_chars(theme)
    return chars["corner"] + chars["edge"] * width + chars["corner"]


def border_side(line, width, theme):
    chars = theme_chars(theme)
    return chars["side"] + line.ljust(width) + chars["side"]
