from formatting import uppercase, underline


def make_banner(title):
    loud = uppercase(title)
    return underline(loud, "=")


def frame(title):
    banner = make_banner(title)
    return "\n".join(["*" * 40, banner, "*" * 40])
