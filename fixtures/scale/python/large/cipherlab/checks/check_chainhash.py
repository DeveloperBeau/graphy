from cipherlab.ciphers.chainhash import chainhash_digest
from cipherlab.specs.chainhash_spec import chainhash_spec
from cipherlab.corpus.corpus_hash import corpus_hash


def check_chainhash():
    spec = chainhash_spec()
    for text in corpus_hash():
        first = chainhash_digest(text)
        second = chainhash_digest(text)
        if first != second or len(first) != 8:
            return False
    return spec["category"] == "hash"
