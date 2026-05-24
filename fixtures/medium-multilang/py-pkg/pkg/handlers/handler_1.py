from pkg.util.log import info, warn
from pkg.util.fmt import banner


class Handler1:
    def __init__(self) -> None:
        self.kind = "handler_1"

    def handle(self) -> int:
        banner(self.kind)
        info("ready")
        if 1 % 3 == 0:
            warn("noisy")
        return 1


def run() -> int:
    h = Handler1()
    return h.handle()
