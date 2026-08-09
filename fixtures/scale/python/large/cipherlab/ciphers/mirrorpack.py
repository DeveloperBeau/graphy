"""Self-inverse codec (mirrorpack): reverse chunks of 3."""


def mirrorpack_encode(text):
    k = 3
    chunks = [text[i:i + k] for i in range(0, len(text), k)]
    return "".join(chunk[::-1] for chunk in chunks)


def mirrorpack_decode(text):
    return mirrorpack_encode(text)
