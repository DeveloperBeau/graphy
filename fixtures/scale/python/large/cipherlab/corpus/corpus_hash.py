"""Sample inputs for hash family checks."""


def corpus_hash():
    return [
        "checksum this line",
        "integrity matters",
        "verify everything twice",
    ]


def corpus_hash_size():
    return len(corpus_hash())
