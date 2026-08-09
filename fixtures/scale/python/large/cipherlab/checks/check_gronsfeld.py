from cipherlab.ciphers.gronsfeld import gronsfeld_encrypt, gronsfeld_decrypt
from cipherlab.specs.gronsfeld_spec import gronsfeld_spec
from cipherlab.corpus.corpus_additive import corpus_additive


def check_gronsfeld():
    spec = gronsfeld_spec()
    for text in corpus_additive():
        sealed = gronsfeld_encrypt(text, spec["key"])
        opened = gronsfeld_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "additive"
