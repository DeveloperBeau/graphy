"""Rotation transposition cipher (carousel)."""


def carousel_offset(text, key):
    return (key + 5) % max(1, len(text))


def carousel_encrypt(text, key):
    n = carousel_offset(text, key)
    return text[n:] + text[:n]


def carousel_decrypt(text, key):
    n = carousel_offset(text, key)
    return text[len(text) - n:] + text[:len(text) - n]
