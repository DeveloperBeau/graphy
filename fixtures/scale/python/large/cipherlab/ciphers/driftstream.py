"""Keystream cipher (driftstream) driven by a small LCG."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def driftstream_encrypt(text, key):
    x = (key * 7 + 208) % 256
    out = []
    for c in to_codes(text):
        x = (33 * x + 208) % 256
        out.append(c ^ x)
    return from_codes(out)


def driftstream_decrypt(text, key):
    return driftstream_encrypt(text, key)
