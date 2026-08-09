"""Rotation transposition cipher (windmill)."""


def windmill_offset(text, key):
    return (key + 1) % max(1, len(text))


def windmill_encrypt(text, key):
    n = windmill_offset(text, key)
    return text[n:] + text[:n]


def windmill_decrypt(text, key):
    n = windmill_offset(text, key)
    return text[len(text) - n:] + text[:len(text) - n]
