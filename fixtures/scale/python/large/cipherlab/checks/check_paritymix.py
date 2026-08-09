from cipherlab.ciphers.paritymix import paritymix_encrypt, paritymix_decrypt
from cipherlab.specs.paritymix_spec import paritymix_spec
from cipherlab.corpus.corpus_mask import corpus_mask


def check_paritymix():
    spec = paritymix_spec()
    for text in corpus_mask():
        sealed = paritymix_encrypt(text, spec["key"])
        opened = paritymix_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "mask"
