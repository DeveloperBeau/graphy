"""Self-inverse codec (pairswap): reverse chunks of 2."""


def pairswap_encode(text):
    k = 2
    chunks = [text[i:i + k] for i in range(0, len(text), k)]
    return "".join(chunk[::-1] for chunk in chunks)


def pairswap_decode(text):
    return pairswap_encode(text)
