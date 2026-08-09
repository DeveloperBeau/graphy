from cipherlab.ciphers.hexpack import hexpack_encode, hexpack_decode
from cipherlab.specs.hexpack_spec import hexpack_spec
from cipherlab.corpus.corpus_codec import corpus_codec


def check_hexpack():
    spec = hexpack_spec()
    for text in corpus_codec():
        packed = hexpack_encode(text)
        if hexpack_decode(packed) != text:
            return False
    return spec["category"] == "codec"
