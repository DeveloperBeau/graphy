from cipherlab.ciphers.ordinal import ordinal_encrypt, ordinal_decrypt
from cipherlab.specs.ordinal_spec import ordinal_spec
from cipherlab.corpus.corpus_additive import corpus_additive


def check_ordinal():
    spec = ordinal_spec()
    for text in corpus_additive():
        sealed = ordinal_encrypt(text, spec["key"])
        opened = ordinal_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "additive"
