"""Self-inverse codec (byteflip): reverse chunks of 4."""


def byteflip_encode(text):
    k = 4
    chunks = [text[i:i + k] for i in range(0, len(text), k)]
    return "".join(chunk[::-1] for chunk in chunks)


def byteflip_decode(text):
    return byteflip_encode(text)
