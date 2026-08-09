"""Rotation transposition cipher (lattice)."""


def lattice_offset(text, key):
    return (key + 3) % max(1, len(text))


def lattice_encrypt(text, key):
    n = lattice_offset(text, key)
    return text[n:] + text[:n]


def lattice_decrypt(text, key):
    n = lattice_offset(text, key)
    return text[len(text) - n:] + text[:len(text) - n]
