from cipherlab.ciphers.foldsum import foldsum_digest
from cipherlab.specs.foldsum_spec import foldsum_spec
from cipherlab.corpus.corpus_hash import corpus_hash


def check_foldsum():
    spec = foldsum_spec()
    for text in corpus_hash():
        first = foldsum_digest(text)
        second = foldsum_digest(text)
        if first != second or len(first) != 8:
            return False
    return spec["category"] == "hash"
