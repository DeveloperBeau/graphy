"""Self-inverse codec (weavecode): reverse chunks of 4."""


def weavecode_encode(text):
    k = 4
    chunks = [text[i:i + k] for i in range(0, len(text), k)]
    return "".join(chunk[::-1] for chunk in chunks)


def weavecode_decode(text):
    return weavecode_encode(text)
