from cipherlab.ciphers.augustus import augustus_encrypt, augustus_decrypt
from cipherlab.specs.augustus_spec import augustus_spec
from cipherlab.corpus.corpus_additive import corpus_additive


def check_augustus():
    spec = augustus_spec()
    for text in corpus_additive():
        sealed = augustus_encrypt(text, spec["key"])
        opened = augustus_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "additive"
