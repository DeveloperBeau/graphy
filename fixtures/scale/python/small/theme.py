THEMES = {
    "plain": {"corner": "+", "edge": "-", "side": "|"},
    "star": {"corner": "*", "edge": "*", "side": "*"},
    "dot": {"corner": ".", "edge": ".", "side": ":"},
}


def theme_chars(name):
    return THEMES.get(name, THEMES["plain"])
