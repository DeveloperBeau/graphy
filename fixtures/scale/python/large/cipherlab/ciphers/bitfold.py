"""Symmetric xor-mask cipher (bitfold)."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def bitfold_mask():
    return [132, 242, 234]


def bitfold_encrypt(text, key):
    mask = bitfold_mask()
    codes = [c ^ mask[i % 3] ^ (key % 256) for i, c in enumerate(to_codes(text))]
    return from_codes(codes)


def bitfold_decrypt(text, key):
    return bitfold_encrypt(text, key)
