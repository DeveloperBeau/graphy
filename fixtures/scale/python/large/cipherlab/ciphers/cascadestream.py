"""Keystream cipher (cascadestream) driven by a small LCG."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def cascadestream_encrypt(text, key):
    x = (key * 7 + 14) % 256
    out = []
    for c in to_codes(text):
        x = (9 * x + 14) % 256
        out.append(c ^ x)
    return from_codes(out)


def cascadestream_decrypt(text, key):
    return cascadestream_encrypt(text, key)
