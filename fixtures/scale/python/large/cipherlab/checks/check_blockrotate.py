from cipherlab.ciphers.blockrotate import blockrotate_encrypt, blockrotate_decrypt
from cipherlab.specs.blockrotate_spec import blockrotate_spec
from cipherlab.corpus.corpus_rotate import corpus_rotate


def check_blockrotate():
    spec = blockrotate_spec()
    for text in corpus_rotate():
        sealed = blockrotate_encrypt(text, spec["key"])
        opened = blockrotate_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "rotate"
