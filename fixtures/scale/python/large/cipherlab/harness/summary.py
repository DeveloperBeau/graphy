from cipherlab.harness.assertions import count_ok
from cipherlab.report.formatter import format_header
from cipherlab.store.reader import count_lines


def summarize(results):
    total = len(results)
    passed = count_ok(results)
    logged = count_lines("session")
    return "{}\n{}/{} passed, {} logged".format(
        format_header(), passed, total, logged
    )


def summarize_checks(outcomes):
    good = sum(1 for _, ok in outcomes if ok)
    return "{}/{} family checks passed".format(good, len(outcomes))
