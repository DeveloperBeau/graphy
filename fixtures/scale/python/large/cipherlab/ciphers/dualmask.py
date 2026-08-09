"""Symmetric xor-mask cipher (dualmask)."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def dualmask_mask():
    return [146, 44, 84]


def dualmask_encrypt(text, key):
    mask = dualmask_mask()
    codes = [c ^ mask[i % 3] ^ (key % 256) for i, c in enumerate(to_codes(text))]
    return from_codes(codes)


def dualmask_decrypt(text, key):
    return dualmask_encrypt(text, key)
