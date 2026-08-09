from cipherlab.ciphers.affine import affine_encrypt, affine_decrypt
from cipherlab.specs.affine_spec import affine_spec
from cipherlab.corpus.corpus_affine import corpus_affine


def check_affine():
    spec = affine_spec()
    for text in corpus_affine():
        sealed = affine_encrypt(text, spec["key"])
        opened = affine_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "affine"
