from cipherlab.core.codec import fingerprint


def digest_line(result):
    return result["name"] + ":" + fingerprint(result["sealed_fp"])


def digest_all(results):
    return "|".join(digest_line(r) for r in results)
