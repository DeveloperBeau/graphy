"""Rotation transposition cipher (conveyor)."""


def conveyor_offset(text, key):
    return (key + 6) % max(1, len(text))


def conveyor_encrypt(text, key):
    n = conveyor_offset(text, key)
    return text[n:] + text[:n]


def conveyor_decrypt(text, key):
    n = conveyor_offset(text, key)
    return text[len(text) - n:] + text[:len(text) - n]
