from cipherlab.ciphers.dualmask import dualmask_encrypt, dualmask_decrypt
from cipherlab.specs.dualmask_spec import dualmask_spec
from cipherlab.corpus.corpus_mask import corpus_mask


def check_dualmask():
    spec = dualmask_spec()
    for text in corpus_mask():
        sealed = dualmask_encrypt(text, spec["key"])
        opened = dualmask_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "mask"
