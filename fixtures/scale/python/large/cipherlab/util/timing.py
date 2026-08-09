import time


def now_ms():
    return int(time.time() * 1000)


def elapsed(start_ms):
    return now_ms() - start_ms


def format_ms(ms):
    return "{}ms".format(ms)
