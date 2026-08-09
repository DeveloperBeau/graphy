from cipherlab.ciphers.skewmap import skewmap_encrypt, skewmap_decrypt
from cipherlab.specs.skewmap_spec import skewmap_spec
from cipherlab.corpus.corpus_affine import corpus_affine


def check_skewmap():
    spec = skewmap_spec()
    for text in corpus_affine():
        sealed = skewmap_encrypt(text, spec["key"])
        opened = skewmap_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "affine"
