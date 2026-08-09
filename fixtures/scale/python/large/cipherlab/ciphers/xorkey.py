"""Symmetric xor-mask cipher (xorkey)."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def xorkey_mask():
    return [111, 155, 75]


def xorkey_encrypt(text, key):
    mask = xorkey_mask()
    codes = [c ^ mask[i % 3] ^ (key % 256) for i, c in enumerate(to_codes(text))]
    return from_codes(codes)


def xorkey_decrypt(text, key):
    return xorkey_encrypt(text, key)
