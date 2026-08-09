from cipherlab.ciphers.mixcrc import mixcrc_digest
from cipherlab.specs.mixcrc_spec import mixcrc_spec
from cipherlab.corpus.corpus_hash import corpus_hash


def check_mixcrc():
    spec = mixcrc_spec()
    for text in corpus_hash():
        first = mixcrc_digest(text)
        second = mixcrc_digest(text)
        if first != second or len(first) != 8:
            return False
    return spec["category"] == "hash"
