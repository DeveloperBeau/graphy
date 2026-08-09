from cipherlab.ciphers.byteflip import byteflip_encode, byteflip_decode
from cipherlab.specs.byteflip_spec import byteflip_spec
from cipherlab.corpus.corpus_codec import corpus_codec


def check_byteflip():
    spec = byteflip_spec()
    for text in corpus_codec():
        packed = byteflip_encode(text)
        if byteflip_decode(packed) != text:
            return False
    return spec["category"] == "codec"
