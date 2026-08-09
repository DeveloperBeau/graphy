from cipherlab.ciphers.caesar import caesar_encrypt, caesar_decrypt
from cipherlab.ciphers.xorkey import xorkey_encrypt, xorkey_decrypt
from cipherlab.ciphers.lcgstream import lcgstream_encrypt, lcgstream_decrypt
from cipherlab.ciphers.carousel import carousel_encrypt, carousel_decrypt
from cipherlab.util.errors import unknown_cipher


def get_cipher(name):
    table = {
        "caesar": (caesar_encrypt, caesar_decrypt),
        "xorkey": (xorkey_encrypt, xorkey_decrypt),
        "lcgstream": (lcgstream_encrypt, lcgstream_decrypt),
        "carousel": (carousel_encrypt, carousel_decrypt),
    }
    if name not in table:
        raise unknown_cipher(name)
    return table[name]
