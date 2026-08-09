from cipherlab.ciphers.weavecode import weavecode_encode, weavecode_decode
from cipherlab.specs.weavecode_spec import weavecode_spec
from cipherlab.corpus.corpus_codec import corpus_codec


def check_weavecode():
    spec = weavecode_spec()
    for text in corpus_codec():
        packed = weavecode_encode(text)
        if weavecode_decode(packed) != text:
            return False
    return spec["category"] == "codec"
