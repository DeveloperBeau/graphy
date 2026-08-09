from cipherlab.harness.runner import run_all
from cipherlab.harness.check_runner import run_checks
from cipherlab.harness.summary import summarize, summarize_checks
from cipherlab.report.live import emit_banner


def main():
    results = run_all()
    emit_banner("family checks")
    outcomes = run_checks()
    emit_banner("done")
    print(summarize(results))
    print(summarize_checks(outcomes))


if __name__ == "__main__":
    main()
