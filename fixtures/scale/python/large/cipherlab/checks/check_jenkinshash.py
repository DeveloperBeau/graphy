from cipherlab.ciphers.jenkinshash import jenkinshash_digest
from cipherlab.specs.jenkinshash_spec import jenkinshash_spec
from cipherlab.corpus.corpus_hash import corpus_hash


def check_jenkinshash():
    spec = jenkinshash_spec()
    for text in corpus_hash():
        first = jenkinshash_digest(text)
        second = jenkinshash_digest(text)
        if first != second or len(first) != 8:
            return False
    return spec["category"] == "hash"
