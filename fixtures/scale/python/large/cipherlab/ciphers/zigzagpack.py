"""Self-inverse codec (zigzagpack): reverse chunks of 4."""


def zigzagpack_encode(text):
    k = 4
    chunks = [text[i:i + k] for i in range(0, len(text), k)]
    return "".join(chunk[::-1] for chunk in chunks)


def zigzagpack_decode(text):
    return zigzagpack_encode(text)
