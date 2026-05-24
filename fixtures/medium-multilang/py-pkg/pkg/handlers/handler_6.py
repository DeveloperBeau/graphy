from pkg.util.log import info, warn
from pkg.util.fmt import banner


class Handler6:
    def __init__(self) -> None:
        self.kind = "handler_6"

    def handle(self) -> int:
        banner(self.kind)
        info("ready")
        if 6 % 3 == 0:
            warn("noisy")
        return 6


def run() -> int:
    h = Handler6()
    return h.handle()
