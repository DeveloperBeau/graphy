from cipherlab.ciphers.splitpack import splitpack_encode, splitpack_decode
from cipherlab.specs.splitpack_spec import splitpack_spec
from cipherlab.corpus.corpus_codec import corpus_codec


def check_splitpack():
    spec = splitpack_spec()
    for text in corpus_codec():
        packed = splitpack_encode(text)
        if splitpack_decode(packed) != text:
            return False
    return spec["category"] == "codec"
