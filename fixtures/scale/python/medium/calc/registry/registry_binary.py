from calc.functions.bi_arctangent import bi_arctangent
from calc.functions.bi_remainder import bi_remainder
from calc.functions.bi_maximum import bi_maximum
from calc.functions.bi_minimum import bi_minimum
from calc.functions.bi_hypotenuse import bi_hypotenuse


def binary_table():
    return {
        "bi_arctangent": bi_arctangent,
        "bi_remainder": bi_remainder,
        "bi_maximum": bi_maximum,
        "bi_minimum": bi_minimum,
        "bi_hypotenuse": bi_hypotenuse,
    }
