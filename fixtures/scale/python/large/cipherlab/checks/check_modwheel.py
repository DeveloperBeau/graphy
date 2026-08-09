from cipherlab.ciphers.modwheel import modwheel_encrypt, modwheel_decrypt
from cipherlab.specs.modwheel_spec import modwheel_spec
from cipherlab.corpus.corpus_affine import corpus_affine


def check_modwheel():
    spec = modwheel_spec()
    for text in corpus_affine():
        sealed = modwheel_encrypt(text, spec["key"])
        opened = modwheel_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "affine"
