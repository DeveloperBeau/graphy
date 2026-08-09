from cipherlab.ciphers.sdbmhash import sdbmhash_digest
from cipherlab.specs.sdbmhash_spec import sdbmhash_spec
from cipherlab.corpus.corpus_hash import corpus_hash


def check_sdbmhash():
    spec = sdbmhash_spec()
    for text in corpus_hash():
        first = sdbmhash_digest(text)
        second = sdbmhash_digest(text)
        if first != second or len(first) != 8:
            return False
    return spec["category"] == "hash"
