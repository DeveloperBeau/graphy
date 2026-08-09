from cipherlab.core.registry import get_cipher
from cipherlab.core.codec import fingerprint
from cipherlab.util.timing import now_ms, elapsed


def round_trip(name, text, key):
    encrypt, decrypt = get_cipher(name)
    start = now_ms()
    sealed = encrypt(text, key)
    opened = decrypt(sealed, key)
    return {
        "name": name,
        "ok": opened == text,
        "sealed_fp": fingerprint(sealed),
        "ms": elapsed(start),
    }
