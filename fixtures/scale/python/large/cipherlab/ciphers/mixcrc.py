"""Rolling digest (mixcrc): init=654435747, multiplier=427799."""
from cipherlab.util.bytes_ops import to_codes


def mixcrc_digest(text):
    h = 654435747
    for c in to_codes(text):
        h = (h * 427799 ^ c) % 4294967296
    return format(h, "08x")


def mixcrc_digest_pair(text):
    return (mixcrc_digest(text), len(text))
