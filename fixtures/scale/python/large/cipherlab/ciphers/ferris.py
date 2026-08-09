"""Rotation transposition cipher (ferris)."""


def ferris_offset(text, key):
    return (key + 2) % max(1, len(text))


def ferris_encrypt(text, key):
    n = ferris_offset(text, key)
    return text[n:] + text[:n]


def ferris_decrypt(text, key):
    n = ferris_offset(text, key)
    return text[len(text) - n:] + text[:len(text) - n]
