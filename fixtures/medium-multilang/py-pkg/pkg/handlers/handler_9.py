from pkg.util.log import info, warn
from pkg.util.fmt import banner


class Handler9:
    def __init__(self) -> None:
        self.kind = "handler_9"

    def handle(self) -> int:
        banner(self.kind)
        info("ready")
        if 9 % 3 == 0:
            warn("noisy")
        return 9


def run() -> int:
    h = Handler9()
    return h.handle()
