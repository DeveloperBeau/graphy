"""Affine byte cipher (promoter): a=3, b derived from key."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def promoter_encrypt(text, key):
    offset = (113 + key) % 256
    return from_codes([(3 * c + offset) % 256 for c in to_codes(text)])


def promoter_decrypt(text, key):
    offset = (113 + key) % 256
    return from_codes([(171 * (c - offset)) % 256 for c in to_codes(text)])
