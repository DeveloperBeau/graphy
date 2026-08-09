"""Rolling digest (sdbmhash): init=166136247, multiplier=777571."""
from cipherlab.util.bytes_ops import to_codes


def sdbmhash_digest(text):
    h = 166136247
    for c in to_codes(text):
        h = (h * 777571 ^ c) % 4294967296
    return format(h, "08x")


def sdbmhash_digest_pair(text):
    return (sdbmhash_digest(text), len(text))
