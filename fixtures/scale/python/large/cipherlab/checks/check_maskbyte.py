from cipherlab.ciphers.maskbyte import maskbyte_encrypt, maskbyte_decrypt
from cipherlab.specs.maskbyte_spec import maskbyte_spec
from cipherlab.corpus.corpus_mask import corpus_mask


def check_maskbyte():
    spec = maskbyte_spec()
    for text in corpus_mask():
        sealed = maskbyte_encrypt(text, spec["key"])
        opened = maskbyte_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "mask"
