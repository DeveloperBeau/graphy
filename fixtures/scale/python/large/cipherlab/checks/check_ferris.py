from cipherlab.ciphers.ferris import ferris_encrypt, ferris_decrypt
from cipherlab.specs.ferris_spec import ferris_spec
from cipherlab.corpus.corpus_rotate import corpus_rotate


def check_ferris():
    spec = ferris_spec()
    for text in corpus_rotate():
        sealed = ferris_encrypt(text, spec["key"])
        opened = ferris_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "rotate"
