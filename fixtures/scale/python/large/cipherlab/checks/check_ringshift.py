from cipherlab.ciphers.ringshift import ringshift_encrypt, ringshift_decrypt
from cipherlab.specs.ringshift_spec import ringshift_spec
from cipherlab.corpus.corpus_rotate import corpus_rotate


def check_ringshift():
    spec = ringshift_spec()
    for text in corpus_rotate():
        sealed = ringshift_encrypt(text, spec["key"])
        opened = ringshift_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "rotate"
