def require_nonempty(text):
    if not text:
        raise ValueError("empty input")
    return text


def require_key(key):
    if key is None or key == "":
        raise ValueError("missing key")
    return key


def clamp_shift(shift):
    return shift % 26
