from cipherlab.ciphers.riverstream import riverstream_encrypt, riverstream_decrypt
from cipherlab.specs.riverstream_spec import riverstream_spec
from cipherlab.corpus.corpus_stream import corpus_stream


def check_riverstream():
    spec = riverstream_spec()
    for text in corpus_stream():
        sealed = riverstream_encrypt(text, spec["key"])
        opened = riverstream_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "stream"
