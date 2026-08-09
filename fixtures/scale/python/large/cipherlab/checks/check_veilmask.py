from cipherlab.ciphers.veilmask import veilmask_encrypt, veilmask_decrypt
from cipherlab.specs.veilmask_spec import veilmask_spec
from cipherlab.corpus.corpus_mask import corpus_mask


def check_veilmask():
    spec = veilmask_spec()
    for text in corpus_mask():
        sealed = veilmask_encrypt(text, spec["key"])
        opened = veilmask_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "mask"
