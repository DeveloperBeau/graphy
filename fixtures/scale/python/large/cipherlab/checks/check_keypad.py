from cipherlab.ciphers.keypad import keypad_encrypt, keypad_decrypt
from cipherlab.specs.keypad_spec import keypad_spec
from cipherlab.corpus.corpus_additive import corpus_additive


def check_keypad():
    spec = keypad_spec()
    for text in corpus_additive():
        sealed = keypad_encrypt(text, spec["key"])
        opened = keypad_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "additive"
