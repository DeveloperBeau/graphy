"""Affine byte cipher (decimation): a=29, b derived from key."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def decimation_encrypt(text, key):
    offset = (102 + key) % 256
    return from_codes([(29 * c + offset) % 256 for c in to_codes(text)])


def decimation_decrypt(text, key):
    offset = (102 + key) % 256
    return from_codes([(53 * (c - offset)) % 256 for c in to_codes(text)])
