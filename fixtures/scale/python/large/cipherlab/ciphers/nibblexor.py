"""Symmetric xor-mask cipher (nibblexor)."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def nibblexor_mask():
    return [153, 73, 137]


def nibblexor_encrypt(text, key):
    mask = nibblexor_mask()
    codes = [c ^ mask[i % 3] ^ (key % 256) for i, c in enumerate(to_codes(text))]
    return from_codes(codes)


def nibblexor_decrypt(text, key):
    return nibblexor_encrypt(text, key)
