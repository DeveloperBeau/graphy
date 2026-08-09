"""Self-inverse codec (splitpack): reverse chunks of 2."""


def splitpack_encode(text):
    k = 2
    chunks = [text[i:i + k] for i in range(0, len(text), k)]
    return "".join(chunk[::-1] for chunk in chunks)


def splitpack_decode(text):
    return splitpack_encode(text)
