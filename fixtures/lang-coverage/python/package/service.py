# feature: class inheriting Greet, methods, all import styles, decorator,
#          cross-file call, external call (print - must not produce local edge).

from collections import OrderedDict
from os.path import join as path_join
from .helpers import format_name
from .types import Greet, State, MAX_RETRIES
from .types import *


def log(fn):
    def wrapper(*a, **kw):
        return fn(*a, **kw)
    return wrapper


class Service(Greet):
    def __init__(self, name: str) -> None:
        self.name = name
        self.cache = OrderedDict()

    @log
    def run(self) -> None:
        greeting = format_name(self.name)
        print(greeting)
        _state = State.RUNNING

    def hi(self) -> str:
        return "hello from service"
