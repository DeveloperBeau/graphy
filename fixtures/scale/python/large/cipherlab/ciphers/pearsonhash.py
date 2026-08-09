"""Rolling digest (pearsonhash): init=65599, multiplier=65599."""
from cipherlab.util.bytes_ops import to_codes


def pearsonhash_digest(text):
    h = 65599
    for c in to_codes(text):
        h = (h * 65599 ^ c) % 4294967296
    return format(h, "08x")


def pearsonhash_digest_pair(text):
    return (pearsonhash_digest(text), len(text))
