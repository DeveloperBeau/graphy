"""Keystream cipher (emberstream) driven by a small LCG."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def emberstream_encrypt(text, key):
    x = (key * 7 + 76) % 256
    out = []
    for c in to_codes(text):
        x = (17 * x + 76) % 256
        out.append(c ^ x)
    return from_codes(out)


def emberstream_decrypt(text, key):
    return emberstream_encrypt(text, key)
