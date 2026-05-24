from pkg.util.log import info

def banner(title: str) -> None:
    info("=" * len(title))
    info(title)
    info("=" * len(title))
