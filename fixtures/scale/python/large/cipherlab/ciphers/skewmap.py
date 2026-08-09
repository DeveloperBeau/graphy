"""Affine byte cipher (skewmap): a=9, b derived from key."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def skewmap_encrypt(text, key):
    offset = (146 + key) % 256
    return from_codes([(9 * c + offset) % 256 for c in to_codes(text)])


def skewmap_decrypt(text, key):
    offset = (146 + key) % 256
    return from_codes([(57 * (c - offset)) % 256 for c in to_codes(text)])
