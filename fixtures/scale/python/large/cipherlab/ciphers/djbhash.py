"""Rolling digest (djbhash): init=131071, multiplier=43."""
from cipherlab.util.bytes_ops import to_codes


def djbhash_digest(text):
    h = 131071
    for c in to_codes(text):
        h = (h * 43 ^ c) % 4294967296
    return format(h, "08x")


def djbhash_digest_pair(text):
    return (djbhash_digest(text), len(text))
