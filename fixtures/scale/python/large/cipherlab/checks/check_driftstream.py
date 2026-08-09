from cipherlab.ciphers.driftstream import driftstream_encrypt, driftstream_decrypt
from cipherlab.specs.driftstream_spec import driftstream_spec
from cipherlab.corpus.corpus_stream import corpus_stream


def check_driftstream():
    spec = driftstream_spec()
    for text in corpus_stream():
        sealed = driftstream_encrypt(text, spec["key"])
        opened = driftstream_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "stream"
