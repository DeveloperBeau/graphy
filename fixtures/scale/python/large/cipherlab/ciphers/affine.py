"""Affine byte cipher (affine): a=25, b derived from key."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def affine_encrypt(text, key):
    offset = (91 + key) % 256
    return from_codes([(25 * c + offset) % 256 for c in to_codes(text)])


def affine_decrypt(text, key):
    offset = (91 + key) % 256
    return from_codes([(41 * (c - offset)) % 256 for c in to_codes(text)])
