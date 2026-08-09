"""Additive byte-shift cipher (trithemius)."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def trithemius_encrypt(text, key):
    shift = (key + 13) % 256
    return from_codes([c + shift for c in to_codes(text)])


def trithemius_decrypt(text, key):
    shift = (key + 13) % 256
    return from_codes([c - shift for c in to_codes(text)])
