from cipherlab.ciphers.tallyhash import tallyhash_digest
from cipherlab.specs.tallyhash_spec import tallyhash_spec
from cipherlab.corpus.corpus_hash import corpus_hash


def check_tallyhash():
    spec = tallyhash_spec()
    for text in corpus_hash():
        first = tallyhash_digest(text)
        second = tallyhash_digest(text)
        if first != second or len(first) != 8:
            return False
    return spec["category"] == "hash"
