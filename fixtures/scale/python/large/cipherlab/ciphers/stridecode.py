"""Self-inverse codec (stridecode): reverse chunks of 2."""


def stridecode_encode(text):
    k = 2
    chunks = [text[i:i + k] for i in range(0, len(text), k)]
    return "".join(chunk[::-1] for chunk in chunks)


def stridecode_decode(text):
    return stridecode_encode(text)
