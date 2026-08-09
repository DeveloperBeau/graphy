"""Rolling digest (weavehash): init=8191, multiplier=37."""
from cipherlab.util.bytes_ops import to_codes


def weavehash_digest(text):
    h = 8191
    for c in to_codes(text):
        h = (h * 37 ^ c) % 4294967296
    return format(h, "08x")


def weavehash_digest_pair(text):
    return (weavehash_digest(text), len(text))
