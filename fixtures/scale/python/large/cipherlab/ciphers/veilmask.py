"""Symmetric xor-mask cipher (veilmask)."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def veilmask_mask():
    return [139, 15, 31]


def veilmask_encrypt(text, key):
    mask = veilmask_mask()
    codes = [c ^ mask[i % 3] ^ (key % 256) for i, c in enumerate(to_codes(text))]
    return from_codes(codes)


def veilmask_decrypt(text, key):
    return veilmask_encrypt(text, key)
