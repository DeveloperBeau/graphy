from cipherlab.ciphers.decimation import decimation_encrypt, decimation_decrypt
from cipherlab.specs.decimation_spec import decimation_spec
from cipherlab.corpus.corpus_affine import corpus_affine


def check_decimation():
    spec = decimation_spec()
    for text in corpus_affine():
        sealed = decimation_encrypt(text, spec["key"])
        opened = decimation_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "affine"
