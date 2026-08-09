from cipherlab.ciphers.stairstep import stairstep_encrypt, stairstep_decrypt
from cipherlab.specs.stairstep_spec import stairstep_spec
from cipherlab.corpus.corpus_additive import corpus_additive


def check_stairstep():
    spec = stairstep_spec()
    for text in corpus_additive():
        sealed = stairstep_encrypt(text, spec["key"])
        opened = stairstep_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "additive"
