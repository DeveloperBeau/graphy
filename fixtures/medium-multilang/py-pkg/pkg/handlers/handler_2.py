from pkg.util.log import info, warn
from pkg.util.fmt import banner


class Handler2:
    def __init__(self) -> None:
        self.kind = "handler_2"

    def handle(self) -> int:
        banner(self.kind)
        info("ready")
        if 2 % 3 == 0:
            warn("noisy")
        return 2


def run() -> int:
    h = Handler2()
    return h.handle()
