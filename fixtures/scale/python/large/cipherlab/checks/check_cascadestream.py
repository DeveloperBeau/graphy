from cipherlab.ciphers.cascadestream import cascadestream_encrypt, cascadestream_decrypt
from cipherlab.specs.cascadestream_spec import cascadestream_spec
from cipherlab.corpus.corpus_stream import corpus_stream


def check_cascadestream():
    spec = cascadestream_spec()
    for text in corpus_stream():
        sealed = cascadestream_encrypt(text, spec["key"])
        opened = cascadestream_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "stream"
