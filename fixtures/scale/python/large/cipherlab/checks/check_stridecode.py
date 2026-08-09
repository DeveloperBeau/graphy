from cipherlab.ciphers.stridecode import stridecode_encode, stridecode_decode
from cipherlab.specs.stridecode_spec import stridecode_spec
from cipherlab.corpus.corpus_codec import corpus_codec


def check_stridecode():
    spec = stridecode_spec()
    for text in corpus_codec():
        packed = stridecode_encode(text)
        if stridecode_decode(packed) != text:
            return False
    return spec["category"] == "codec"
