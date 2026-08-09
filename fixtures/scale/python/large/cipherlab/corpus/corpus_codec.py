"""Sample inputs for codec family checks."""


def corpus_codec():
    return [
        "pack and unpack",
        "mirror the message",
        "swap every pair",
    ]


def corpus_codec_size():
    return len(corpus_codec())
