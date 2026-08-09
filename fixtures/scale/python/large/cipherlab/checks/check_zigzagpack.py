from cipherlab.ciphers.zigzagpack import zigzagpack_encode, zigzagpack_decode
from cipherlab.specs.zigzagpack_spec import zigzagpack_spec
from cipherlab.corpus.corpus_codec import corpus_codec


def check_zigzagpack():
    spec = zigzagpack_spec()
    for text in corpus_codec():
        packed = zigzagpack_encode(text)
        if zigzagpack_decode(packed) != text:
            return False
    return spec["category"] == "codec"
