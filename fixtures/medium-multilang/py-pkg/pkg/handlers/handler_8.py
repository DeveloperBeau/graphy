from pkg.util.log import info, warn
from pkg.util.fmt import banner


class Handler8:
    def __init__(self) -> None:
        self.kind = "handler_8"

    def handle(self) -> int:
        banner(self.kind)
        info("ready")
        if 8 % 3 == 0:
            warn("noisy")
        return 8


def run() -> int:
    h = Handler8()
    return h.handle()
