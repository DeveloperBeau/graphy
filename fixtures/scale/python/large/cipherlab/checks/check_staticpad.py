from cipherlab.ciphers.staticpad import staticpad_encrypt, staticpad_decrypt
from cipherlab.specs.staticpad_spec import staticpad_spec
from cipherlab.corpus.corpus_mask import corpus_mask


def check_staticpad():
    spec = staticpad_spec()
    for text in corpus_mask():
        sealed = staticpad_encrypt(text, spec["key"])
        opened = staticpad_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "mask"
