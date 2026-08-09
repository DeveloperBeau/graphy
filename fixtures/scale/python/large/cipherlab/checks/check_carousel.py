from cipherlab.ciphers.carousel import carousel_encrypt, carousel_decrypt
from cipherlab.specs.carousel_spec import carousel_spec
from cipherlab.corpus.corpus_rotate import corpus_rotate


def check_carousel():
    spec = carousel_spec()
    for text in corpus_rotate():
        sealed = carousel_encrypt(text, spec["key"])
        opened = carousel_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "rotate"
