from cipherlab.ciphers.pairswap import pairswap_encode, pairswap_decode
from cipherlab.specs.pairswap_spec import pairswap_spec
from cipherlab.corpus.corpus_codec import corpus_codec


def check_pairswap():
    spec = pairswap_spec()
    for text in corpus_codec():
        packed = pairswap_encode(text)
        if pairswap_decode(packed) != text:
            return False
    return spec["category"] == "codec"
