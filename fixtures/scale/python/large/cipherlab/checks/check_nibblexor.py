from cipherlab.ciphers.nibblexor import nibblexor_encrypt, nibblexor_decrypt
from cipherlab.specs.nibblexor_spec import nibblexor_spec
from cipherlab.corpus.corpus_mask import corpus_mask


def check_nibblexor():
    spec = nibblexor_spec()
    for text in corpus_mask():
        sealed = nibblexor_encrypt(text, spec["key"])
        opened = nibblexor_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "mask"
