"""Keystream cipher (riverstream) driven by a small LCG."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def riverstream_encrypt(text, key):
    x = (key * 7 + 107) % 256
    out = []
    for c in to_codes(text):
        x = (21 * x + 107) % 256
        out.append(c ^ x)
    return from_codes(out)


def riverstream_decrypt(text, key):
    return riverstream_encrypt(text, key)
