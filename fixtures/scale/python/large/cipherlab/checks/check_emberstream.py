from cipherlab.ciphers.emberstream import emberstream_encrypt, emberstream_decrypt
from cipherlab.specs.emberstream_spec import emberstream_spec
from cipherlab.corpus.corpus_stream import corpus_stream


def check_emberstream():
    spec = emberstream_spec()
    for text in corpus_stream():
        sealed = emberstream_encrypt(text, spec["key"])
        opened = emberstream_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "stream"
