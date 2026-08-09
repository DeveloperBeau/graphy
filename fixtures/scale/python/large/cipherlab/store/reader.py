import os
from cipherlab.store.paths import result_path


def read_result(name):
    path = result_path(name)
    if not os.path.exists(path):
        return []
    with open(path) as fh:
        return [line.rstrip() for line in fh]


def count_lines(name):
    return len(read_result(name))
