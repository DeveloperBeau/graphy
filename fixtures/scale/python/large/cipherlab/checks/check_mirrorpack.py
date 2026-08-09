from cipherlab.ciphers.mirrorpack import mirrorpack_encode, mirrorpack_decode
from cipherlab.specs.mirrorpack_spec import mirrorpack_spec
from cipherlab.corpus.corpus_codec import corpus_codec


def check_mirrorpack():
    spec = mirrorpack_spec()
    for text in corpus_codec():
        packed = mirrorpack_encode(text)
        if mirrorpack_decode(packed) != text:
            return False
    return spec["category"] == "codec"
