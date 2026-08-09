"""Affine byte cipher (modwheel): a=5, b derived from key."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def modwheel_encrypt(text, key):
    offset = (124 + key) % 256
    return from_codes([(5 * c + offset) % 256 for c in to_codes(text)])


def modwheel_decrypt(text, key):
    offset = (124 + key) % 256
    return from_codes([(205 * (c - offset)) % 256 for c in to_codes(text)])
