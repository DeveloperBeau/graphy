"""Self-inverse codec (nibbleswap): reverse chunks of 3."""


def nibbleswap_encode(text):
    k = 3
    chunks = [text[i:i + k] for i in range(0, len(text), k)]
    return "".join(chunk[::-1] for chunk in chunks)


def nibbleswap_decode(text):
    return nibbleswap_encode(text)
