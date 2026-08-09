"""Symmetric xor-mask cipher (paritymix)."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def paritymix_mask():
    return [125, 213, 181]


def paritymix_encrypt(text, key):
    mask = paritymix_mask()
    codes = [c ^ mask[i % 3] ^ (key % 256) for i, c in enumerate(to_codes(text))]
    return from_codes(codes)


def paritymix_decrypt(text, key):
    return paritymix_encrypt(text, key)
