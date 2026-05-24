from pkg.util.log import info, warn
from pkg.util.fmt import banner


class Handler3:
    def __init__(self) -> None:
        self.kind = "handler_3"

    def handle(self) -> int:
        banner(self.kind)
        info("ready")
        if 3 % 3 == 0:
            warn("noisy")
        return 3


def run() -> int:
    h = Handler3()
    return h.handle()
