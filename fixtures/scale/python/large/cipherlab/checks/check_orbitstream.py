from cipherlab.ciphers.orbitstream import orbitstream_encrypt, orbitstream_decrypt
from cipherlab.specs.orbitstream_spec import orbitstream_spec
from cipherlab.corpus.corpus_stream import corpus_stream


def check_orbitstream():
    spec = orbitstream_spec()
    for text in corpus_stream():
        sealed = orbitstream_encrypt(text, spec["key"])
        opened = orbitstream_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "stream"
