"""Keystream cipher (sparkstream) driven by a small LCG."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def sparkstream_encrypt(text, key):
    x = (key * 7 + 138) % 256
    out = []
    for c in to_codes(text):
        x = (25 * x + 138) % 256
        out.append(c ^ x)
    return from_codes(out)


def sparkstream_decrypt(text, key):
    return sparkstream_encrypt(text, key)
