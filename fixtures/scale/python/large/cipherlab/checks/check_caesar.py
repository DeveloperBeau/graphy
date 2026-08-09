from cipherlab.ciphers.caesar import caesar_encrypt, caesar_decrypt
from cipherlab.specs.caesar_spec import caesar_spec
from cipherlab.corpus.corpus_additive import corpus_additive


def check_caesar():
    spec = caesar_spec()
    for text in corpus_additive():
        sealed = caesar_encrypt(text, spec["key"])
        opened = caesar_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "additive"
