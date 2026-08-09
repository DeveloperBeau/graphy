from cipherlab.ciphers.pearsonhash import pearsonhash_digest
from cipherlab.specs.pearsonhash_spec import pearsonhash_spec
from cipherlab.corpus.corpus_hash import corpus_hash


def check_pearsonhash():
    spec = pearsonhash_spec()
    for text in corpus_hash():
        first = pearsonhash_digest(text)
        second = pearsonhash_digest(text)
        if first != second or len(first) != 8:
            return False
    return spec["category"] == "hash"
