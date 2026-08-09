"""Keystream cipher (lcgstream) driven by a small LCG."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def lcgstream_encrypt(text, key):
    x = (key * 7 + 177) % 256
    out = []
    for c in to_codes(text):
        x = (29 * x + 177) % 256
        out.append(c ^ x)
    return from_codes(out)


def lcgstream_decrypt(text, key):
    return lcgstream_encrypt(text, key)
