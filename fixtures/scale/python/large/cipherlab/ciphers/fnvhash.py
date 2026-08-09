"""Rolling digest (fnvhash): init=524287, multiplier=41."""
from cipherlab.util.bytes_ops import to_codes


def fnvhash_digest(text):
    h = 524287
    for c in to_codes(text):
        h = (h * 41 ^ c) % 4294967296
    return format(h, "08x")


def fnvhash_digest_pair(text):
    return (fnvhash_digest(text), len(text))
