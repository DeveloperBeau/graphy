"""Rolling digest (tallyhash): init=97, multiplier=31."""
from cipherlab.util.bytes_ops import to_codes


def tallyhash_digest(text):
    h = 97
    for c in to_codes(text):
        h = (h * 31 ^ c) % 4294967296
    return format(h, "08x")


def tallyhash_digest_pair(text):
    return (tallyhash_digest(text), len(text))
