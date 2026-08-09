"""Keystream cipher (pulsestream) driven by a small LCG."""
from cipherlab.util.bytes_ops import to_codes, from_codes


def pulsestream_encrypt(text, key):
    x = (key * 7 + 239) % 256
    out = []
    for c in to_codes(text):
        x = (5 * x + 239) % 256
        out.append(c ^ x)
    return from_codes(out)


def pulsestream_decrypt(text, key):
    return pulsestream_encrypt(text, key)
