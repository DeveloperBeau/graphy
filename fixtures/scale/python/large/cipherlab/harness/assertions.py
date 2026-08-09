from cipherlab.util.errors import roundtrip_failed


def assert_ok(result):
    if not result["ok"]:
        raise roundtrip_failed(result["name"])
    return True


def count_ok(results):
    return sum(1 for r in results if r["ok"])
