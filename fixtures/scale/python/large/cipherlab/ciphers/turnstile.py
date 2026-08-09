"""Rotation transposition cipher (turnstile)."""


def turnstile_offset(text, key):
    return (key + 7) % max(1, len(text))


def turnstile_encrypt(text, key):
    n = turnstile_offset(text, key)
    return text[n:] + text[:n]


def turnstile_decrypt(text, key):
    n = turnstile_offset(text, key)
    return text[len(text) - n:] + text[:len(text) - n]
