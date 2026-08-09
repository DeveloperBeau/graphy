class CipherError(Exception):
    pass


def unknown_cipher(name):
    return CipherError("unknown cipher: " + name)


def roundtrip_failed(name):
    return CipherError("round trip mismatch: " + name)
