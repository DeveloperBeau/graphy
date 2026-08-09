from cipherlab.ciphers.promoter import promoter_encrypt, promoter_decrypt
from cipherlab.specs.promoter_spec import promoter_spec
from cipherlab.corpus.corpus_affine import corpus_affine


def check_promoter():
    spec = promoter_spec()
    for text in corpus_affine():
        sealed = promoter_encrypt(text, spec["key"])
        opened = promoter_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "affine"
