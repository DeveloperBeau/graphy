"""Additive byte-shift cipher (keypad)."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def keypad_encrypt(text, key):
    shift = (key + 10) % 256
    return from_codes([c + shift for c in to_codes(text)])


def keypad_decrypt(text, key):
    shift = (key + 10) % 256
    return from_codes([c - shift for c in to_codes(text)])
