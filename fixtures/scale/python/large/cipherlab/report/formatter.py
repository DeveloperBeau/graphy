def format_row(result):
    status = "OK " if result["ok"] else "BAD"
    return "{} {:<12} fp={} {}ms".format(
        status, result["name"], result["sealed_fp"], result["ms"]
    )


def format_header():
    return "=== cipher round-trip report ==="


def format_check(name, ok):
    return "{} check {}".format("PASS" if ok else "FAIL", name)
