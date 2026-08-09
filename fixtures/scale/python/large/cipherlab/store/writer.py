import os
from cipherlab.store.paths import store_dir, result_path


def ensure_dir():
    os.makedirs(store_dir(), exist_ok=True)


def write_result(name, line):
    ensure_dir()
    with open(result_path(name), "a") as fh:
        fh.write(line + "\n")


def clear_result(name):
    ensure_dir()
    open(result_path(name), "w").close()
