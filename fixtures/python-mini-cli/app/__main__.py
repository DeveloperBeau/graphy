from app.commands import hello, status
from app.util import banner


def main() -> int:
    banner("mini-cli")
    hello.run("world")
    status.run()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
