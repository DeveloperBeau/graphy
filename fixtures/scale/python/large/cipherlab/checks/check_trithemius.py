from cipherlab.ciphers.trithemius import trithemius_encrypt, trithemius_decrypt
from cipherlab.specs.trithemius_spec import trithemius_spec
from cipherlab.corpus.corpus_additive import corpus_additive


def check_trithemius():
    spec = trithemius_spec()
    for text in corpus_additive():
        sealed = trithemius_encrypt(text, spec["key"])
        opened = trithemius_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "additive"
