from cipherlab.ciphers.turnstile import turnstile_encrypt, turnstile_decrypt
from cipherlab.specs.turnstile_spec import turnstile_spec
from cipherlab.corpus.corpus_rotate import corpus_rotate


def check_turnstile():
    spec = turnstile_spec()
    for text in corpus_rotate():
        sealed = turnstile_encrypt(text, spec["key"])
        opened = turnstile_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "rotate"
