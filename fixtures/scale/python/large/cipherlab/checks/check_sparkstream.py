from cipherlab.ciphers.sparkstream import sparkstream_encrypt, sparkstream_decrypt
from cipherlab.specs.sparkstream_spec import sparkstream_spec
from cipherlab.corpus.corpus_stream import corpus_stream


def check_sparkstream():
    spec = sparkstream_spec()
    for text in corpus_stream():
        sealed = sparkstream_encrypt(text, spec["key"])
        opened = sparkstream_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "stream"
