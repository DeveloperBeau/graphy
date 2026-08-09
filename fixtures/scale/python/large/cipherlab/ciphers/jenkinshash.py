"""Rolling digest (jenkinshash): init=5381, multiplier=33."""
from cipherlab.util.bytes_ops import to_codes


def jenkinshash_digest(text):
    h = 5381
    for c in to_codes(text):
        h = (h * 33 ^ c) % 4294967296
    return format(h, "08x")


def jenkinshash_digest_pair(text):
    return (jenkinshash_digest(text), len(text))
