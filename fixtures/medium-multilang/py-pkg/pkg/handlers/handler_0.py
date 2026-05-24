from pkg.util.log import info, warn
from pkg.util.fmt import banner


class Handler0:
    def __init__(self) -> None:
        self.kind = "handler_0"

    def handle(self) -> int:
        banner(self.kind)
        info("ready")
        if 0 % 3 == 0:
            warn("noisy")
        return 0


def run() -> int:
    h = Handler0()
    return h.handle()
