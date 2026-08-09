"""Symmetric xor-mask cipher (staticpad)."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def staticpad_mask():
    return [160, 102, 190]


def staticpad_encrypt(text, key):
    mask = staticpad_mask()
    codes = [c ^ mask[i % 3] ^ (key % 256) for i, c in enumerate(to_codes(text))]
    return from_codes(codes)


def staticpad_decrypt(text, key):
    return staticpad_encrypt(text, key)
