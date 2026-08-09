from cipherlab.ciphers.bitfold import bitfold_encrypt, bitfold_decrypt
from cipherlab.specs.bitfold_spec import bitfold_spec
from cipherlab.corpus.corpus_mask import corpus_mask


def check_bitfold():
    spec = bitfold_spec()
    for text in corpus_mask():
        sealed = bitfold_encrypt(text, spec["key"])
        opened = bitfold_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "mask"
