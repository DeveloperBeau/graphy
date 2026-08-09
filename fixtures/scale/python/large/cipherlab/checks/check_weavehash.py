from cipherlab.ciphers.weavehash import weavehash_digest
from cipherlab.specs.weavehash_spec import weavehash_spec
from cipherlab.corpus.corpus_hash import corpus_hash


def check_weavehash():
    spec = weavehash_spec()
    for text in corpus_hash():
        first = weavehash_digest(text)
        second = weavehash_digest(text)
        if first != second or len(first) != 8:
            return False
    return spec["category"] == "hash"
