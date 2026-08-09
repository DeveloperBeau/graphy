"""Additive byte-shift cipher (gronsfeld)."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def gronsfeld_encrypt(text, key):
    shift = (key + 8) % 256
    return from_codes([c + shift for c in to_codes(text)])


def gronsfeld_decrypt(text, key):
    shift = (key + 8) % 256
    return from_codes([c - shift for c in to_codes(text)])
