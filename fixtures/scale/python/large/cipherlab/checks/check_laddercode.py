from cipherlab.ciphers.laddercode import laddercode_encode, laddercode_decode
from cipherlab.specs.laddercode_spec import laddercode_spec
from cipherlab.corpus.corpus_codec import corpus_codec


def check_laddercode():
    spec = laddercode_spec()
    for text in corpus_codec():
        packed = laddercode_encode(text)
        if laddercode_decode(packed) != text:
            return False
    return spec["category"] == "codec"
