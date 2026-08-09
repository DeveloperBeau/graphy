"""Additive byte-shift cipher (shiftreel)."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def shiftreel_encrypt(text, key):
    shift = (key + 18) % 256
    return from_codes([c + shift for c in to_codes(text)])


def shiftreel_decrypt(text, key):
    shift = (key + 18) % 256
    return from_codes([c - shift for c in to_codes(text)])
