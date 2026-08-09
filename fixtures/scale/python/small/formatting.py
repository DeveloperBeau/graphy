def uppercase(text):
    return text.upper()


def indent(text, width):
    pad = " " * width
    return "\n".join(pad + line for line in text.splitlines())


def underline(text, char="-"):
    return text + "\n" + char * len(text)
