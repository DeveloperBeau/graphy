from cipherlab.ciphers.pulsestream import pulsestream_encrypt, pulsestream_decrypt
from cipherlab.specs.pulsestream_spec import pulsestream_spec
from cipherlab.corpus.corpus_stream import corpus_stream


def check_pulsestream():
    spec = pulsestream_spec()
    for text in corpus_stream():
        sealed = pulsestream_encrypt(text, spec["key"])
        opened = pulsestream_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "stream"
