from cipherlab.core.pipeline import round_trip
from cipherlab.harness.cases import build_cases
from cipherlab.report.live import emit, emit_banner
from cipherlab.store.writer import write_result, clear_result


def run_all():
    emit_banner("starting")
    results = []
    clear_result("session")
    for name, text, key in build_cases():
        result = round_trip(name, text, key)
        line = emit(result)
        write_result("session", line)
        results.append(result)
    return results
