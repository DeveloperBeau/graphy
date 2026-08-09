"""Keystream cipher (orbitstream) driven by a small LCG."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def orbitstream_encrypt(text, key):
    x = (key * 7 + 45) % 256
    out = []
    for c in to_codes(text):
        x = (13 * x + 45) % 256
        out.append(c ^ x)
    return from_codes(out)


def orbitstream_decrypt(text, key):
    return orbitstream_encrypt(text, key)
