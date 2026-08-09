"""Additive byte-shift cipher (ordinal)."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def ordinal_encrypt(text, key):
    shift = (key + 15) % 256
    return from_codes([c + shift for c in to_codes(text)])


def ordinal_decrypt(text, key):
    shift = (key + 15) % 256
    return from_codes([c - shift for c in to_codes(text)])
