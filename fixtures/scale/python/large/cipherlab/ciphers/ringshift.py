"""Rotation transposition cipher (ringshift)."""


def ringshift_offset(text, key):
    return (key + 4) % max(1, len(text))


def ringshift_encrypt(text, key):
    n = ringshift_offset(text, key)
    return text[n:] + text[:n]


def ringshift_decrypt(text, key):
    n = ringshift_offset(text, key)
    return text[len(text) - n:] + text[:len(text) - n]
