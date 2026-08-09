from cipherlab.ciphers.linearmix import linearmix_encrypt, linearmix_decrypt
from cipherlab.specs.linearmix_spec import linearmix_spec
from cipherlab.corpus.corpus_affine import corpus_affine


def check_linearmix():
    spec = linearmix_spec()
    for text in corpus_affine():
        sealed = linearmix_encrypt(text, spec["key"])
        opened = linearmix_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "affine"
