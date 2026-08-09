from cipherlab.ciphers.windmill import windmill_encrypt, windmill_decrypt
from cipherlab.specs.windmill_spec import windmill_spec
from cipherlab.corpus.corpus_rotate import corpus_rotate


def check_windmill():
    spec = windmill_spec()
    for text in corpus_rotate():
        sealed = windmill_encrypt(text, spec["key"])
        opened = windmill_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "rotate"
