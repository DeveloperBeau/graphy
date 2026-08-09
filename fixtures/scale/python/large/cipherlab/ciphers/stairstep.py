"""Additive byte-shift cipher (stairstep)."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def stairstep_encrypt(text, key):
    shift = (key + 23) % 256
    return from_codes([c + shift for c in to_codes(text)])


def stairstep_decrypt(text, key):
    shift = (key + 23) % 256
    return from_codes([c - shift for c in to_codes(text)])
