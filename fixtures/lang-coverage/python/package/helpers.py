# feature: top-level function, called cross-file

def format_name(name: str) -> str:
    return "hi, " + name


def unrelated_helper() -> int:
    return 7
