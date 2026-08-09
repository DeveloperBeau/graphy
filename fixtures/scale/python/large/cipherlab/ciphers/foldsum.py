"""Rolling digest (foldsum): init=40503, multiplier=40503."""
from cipherlab.util.bytes_ops import to_codes


def foldsum_digest(text):
    h = 40503
    for c in to_codes(text):
        h = (h * 40503 ^ c) % 4294967296
    return format(h, "08x")


def foldsum_digest_pair(text):
    return (foldsum_digest(text), len(text))
