from pkg.util.log import info, warn
from pkg.util.fmt import banner


class Handler4:
    def __init__(self) -> None:
        self.kind = "handler_4"

    def handle(self) -> int:
        banner(self.kind)
        info("ready")
        if 4 % 3 == 0:
            warn("noisy")
        return 4


def run() -> int:
    h = Handler4()
    return h.handle()
