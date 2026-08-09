from cipherlab.ciphers.fnvhash import fnvhash_digest
from cipherlab.specs.fnvhash_spec import fnvhash_spec
from cipherlab.corpus.corpus_hash import corpus_hash


def check_fnvhash():
    spec = fnvhash_spec()
    for text in corpus_hash():
        first = fnvhash_digest(text)
        second = fnvhash_digest(text)
        if first != second or len(first) != 8:
            return False
    return spec["category"] == "hash"
