"""Rolling digest (chainhash): init=131, multiplier=131."""
from cipherlab.util.bytes_ops import to_codes


def chainhash_digest(text):
    h = 131
    for c in to_codes(text):
        h = (h * 131 ^ c) % 4294967296
    return format(h, "08x")


def chainhash_digest_pair(text):
    return (chainhash_digest(text), len(text))
