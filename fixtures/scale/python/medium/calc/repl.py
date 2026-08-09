from calc.evaluator import evaluate
from calc.history import History
from calc.formatting import format_line


def run_batch(expressions):
    log = History()
    for expr in expressions:
        value = evaluate(expr)
        log.record(expr, value)
        print(format_line(expr, value))
    return log
