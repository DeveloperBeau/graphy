def banner(title: str) -> None:
    bar = "=" * len(title)
    print(f"{bar}\n{title}\n{bar}")


def say(line: str) -> None:
    print(f"> {line}")
