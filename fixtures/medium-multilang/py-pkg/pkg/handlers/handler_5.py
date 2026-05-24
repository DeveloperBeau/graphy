from pkg.util.log import info, warn
from pkg.util.fmt import banner


class Handler5:
    def __init__(self) -> None:
        self.kind = "handler_5"

    def handle(self) -> int:
        banner(self.kind)
        info("ready")
        if 5 % 3 == 0:
            warn("noisy")
        return 5


def run() -> int:
    h = Handler5()
    return h.handle()
