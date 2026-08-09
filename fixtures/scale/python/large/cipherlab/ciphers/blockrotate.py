"""Rotation transposition cipher (blockrotate)."""


def blockrotate_offset(text, key):
    return (key + 3) % max(1, len(text))


def blockrotate_encrypt(text, key):
    n = blockrotate_offset(text, key)
    return text[n:] + text[:n]


def blockrotate_decrypt(text, key):
    n = blockrotate_offset(text, key)
    return text[len(text) - n:] + text[:len(text) - n]
