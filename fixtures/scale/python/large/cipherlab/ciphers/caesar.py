"""Additive byte-shift cipher (caesar)."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def caesar_encrypt(text, key):
    shift = (key + 3) % 256
    return from_codes([c + shift for c in to_codes(text)])


def caesar_decrypt(text, key):
    shift = (key + 3) % 256
    return from_codes([c - shift for c in to_codes(text)])
