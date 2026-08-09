"""Additive byte-shift cipher (augustus)."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def augustus_encrypt(text, key):
    shift = (key + 5) % 256
    return from_codes([c + shift for c in to_codes(text)])


def augustus_decrypt(text, key):
    shift = (key + 5) % 256
    return from_codes([c - shift for c in to_codes(text)])
