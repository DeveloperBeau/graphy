"""Self-inverse codec (hexpack): reverse chunks of 2."""


def hexpack_encode(text):
    k = 2
    chunks = [text[i:i + k] for i in range(0, len(text), k)]
    return "".join(chunk[::-1] for chunk in chunks)


def hexpack_decode(text):
    return hexpack_encode(text)
