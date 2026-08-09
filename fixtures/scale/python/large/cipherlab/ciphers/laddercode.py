"""Self-inverse codec (laddercode): reverse chunks of 3."""


def laddercode_encode(text):
    k = 3
    chunks = [text[i:i + k] for i in range(0, len(text), k)]
    return "".join(chunk[::-1] for chunk in chunks)


def laddercode_decode(text):
    return laddercode_encode(text)
