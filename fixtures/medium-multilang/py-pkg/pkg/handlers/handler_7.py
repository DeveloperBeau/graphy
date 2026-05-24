from pkg.util.log import info, warn
from pkg.util.fmt import banner


class Handler7:
    def __init__(self) -> None:
        self.kind = "handler_7"

    def handle(self) -> int:
        banner(self.kind)
        info("ready")
        if 7 % 3 == 0:
            warn("noisy")
        return 7


def run() -> int:
    h = Handler7()
    return h.handle()
