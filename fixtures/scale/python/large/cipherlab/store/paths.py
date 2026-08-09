import os


def store_dir():
    return os.path.join(os.getcwd(), "runs")


def result_path(name):
    return os.path.join(store_dir(), name + ".log")
