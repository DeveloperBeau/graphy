from cipherlab.ciphers.lattice import lattice_encrypt, lattice_decrypt
from cipherlab.specs.lattice_spec import lattice_spec
from cipherlab.corpus.corpus_rotate import corpus_rotate


def check_lattice():
    spec = lattice_spec()
    for text in corpus_rotate():
        sealed = lattice_encrypt(text, spec["key"])
        opened = lattice_decrypt(sealed, spec["key"])
        if opened != text:
            return False
    return spec["category"] == "rotate"
