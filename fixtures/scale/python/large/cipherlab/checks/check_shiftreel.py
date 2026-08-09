from cipherlab.ciphers.shiftreel import shiftreel_encrypt, shiftreel_decrypt
from cipherlab.specs.shiftreel_spec import shiftreel_spec
from cipherlab.corpus.corpus_additive import corpus_additive


def check_shiftreel():
    spec = shiftreel_spec()
    for text in corpus_additive():
        sealed = shiftreel_encrypt(text, spec["key"])
        opened = shiftreel_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "additive"
