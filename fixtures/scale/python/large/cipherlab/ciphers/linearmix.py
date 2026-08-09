"""Affine byte cipher (linearmix): a=7, b derived from key."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def linearmix_encrypt(text, key):
    offset = (135 + key) % 256
    return from_codes([(7 * c + offset) % 256 for c in to_codes(text)])


def linearmix_decrypt(text, key):
    offset = (135 + key) % 256
    return from_codes([(183 * (c - offset)) % 256 for c in to_codes(text)])
