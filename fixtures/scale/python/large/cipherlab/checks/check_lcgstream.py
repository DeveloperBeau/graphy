from cipherlab.ciphers.lcgstream import lcgstream_encrypt, lcgstream_decrypt
from cipherlab.specs.lcgstream_spec import lcgstream_spec
from cipherlab.corpus.corpus_stream import corpus_stream


def check_lcgstream():
    spec = lcgstream_spec()
    for text in corpus_stream():
        sealed = lcgstream_encrypt(text, spec["key"])
        opened = lcgstream_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "stream"
