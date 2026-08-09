from calc.repl import run_batch
from calc.funcs import apply_named


def main():
    exprs = ["1 + 2 * 3", "(4 + 5) / 3", "2 ^ 8", "10 - 4 - 3"]
    log = run_batch(exprs)
    print("---")
    print(log.dump())
    print(apply_named("trig_sine", [0.5]))
    print(apply_named("bi_hypotenuse", [3, 4]))


if __name__ == "__main__":
    main()
