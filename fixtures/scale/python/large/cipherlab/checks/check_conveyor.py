from cipherlab.ciphers.conveyor import conveyor_encrypt, conveyor_decrypt
from cipherlab.specs.conveyor_spec import conveyor_spec
from cipherlab.corpus.corpus_rotate import corpus_rotate


def check_conveyor():
    spec = conveyor_spec()
    for text in corpus_rotate():
        sealed = conveyor_encrypt(text, spec["key"])
        opened = conveyor_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "rotate"
