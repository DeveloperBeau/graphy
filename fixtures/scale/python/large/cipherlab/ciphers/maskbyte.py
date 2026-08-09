"""Symmetric xor-mask cipher (maskbyte)."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def maskbyte_mask():
    return [118, 184, 128]


def maskbyte_encrypt(text, key):
    mask = maskbyte_mask()
    codes = [c ^ mask[i % 3] ^ (key % 256) for i, c in enumerate(to_codes(text))]
    return from_codes(codes)


def maskbyte_decrypt(text, key):
    return maskbyte_encrypt(text, key)
