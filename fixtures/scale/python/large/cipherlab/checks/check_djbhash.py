from cipherlab.ciphers.djbhash import djbhash_digest
from cipherlab.specs.djbhash_spec import djbhash_spec
from cipherlab.corpus.corpus_hash import corpus_hash


def check_djbhash():
    spec = djbhash_spec()
    for text in corpus_hash():
        first = djbhash_digest(text)
        second = djbhash_digest(text)
        if first != second or len(first) != 8:
            return False
    return spec["category"] == "hash"
