from cipherlab.ciphers.xorkey import xorkey_encrypt, xorkey_decrypt
from cipherlab.specs.xorkey_spec import xorkey_spec
from cipherlab.corpus.corpus_mask import corpus_mask


def check_xorkey():
    spec = xorkey_spec()
    for text in corpus_mask():
        sealed = xorkey_encrypt(text, spec["key"])
        opened = xorkey_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "mask"
