from cipherlab.ciphers.nibbleswap import nibbleswap_encode, nibbleswap_decode
from cipherlab.specs.nibbleswap_spec import nibbleswap_spec
from cipherlab.corpus.corpus_codec import corpus_codec


def check_nibbleswap():
    spec = nibbleswap_spec()
    for text in corpus_codec():
        packed = nibbleswap_encode(text)
        if nibbleswap_decode(packed) != text:
            return False
    return spec["category"] == "codec"
